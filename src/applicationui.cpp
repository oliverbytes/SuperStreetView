#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/system/InvokeRequest>
#include <bb/cascades/Invocation>
#include <bb/system/SystemDialog>
#include <bb/system/SystemToast>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemProgressDialog>
#include <bb/device/DisplayInfo>

#include <bps/bps.h>
#include <bps/audiomixer.h>

using namespace bb::device;
using namespace bb::cascades;
using namespace bb::system;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{
	invokeManager = new InvokeManager();

    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    if(!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()))) {
        qWarning() << "Recovering from a failed connect()";
    }
    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("_app", this);

    DisplayInfo display;
	int width = display.pixelSize().width();
	int height = display.pixelSize().height();

	QDeclarativePropertyMap* displayProperties = new QDeclarativePropertyMap;
	displayProperties->insert("width", QVariant(width));
	displayProperties->insert("height", QVariant(height));

	qml->setContextProperty("DisplayInfo", displayProperties);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}

void ApplicationUI::setVolume(float volume)
{
	audiomixer_set_output_level(AUDIOMIXER_OUTPUT_SPEAKER, volume);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("AppForSpotify_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

QString ApplicationUI::getSetting(const QString &objectName, const QString &defaultValue)
{
	QSettings settings;

	if (settings.value(objectName).isNull()
			|| settings.value(objectName) == "") {
		return defaultValue;
	}

	return settings.value(objectName).toString();
}

void ApplicationUI::setSetting(const QString &objectName, const QString &inputValue)
{
	QSettings settings;
	settings.setValue(objectName, QVariant(inputValue));
}

void ApplicationUI::showToast(const QString &text) {
	SystemToast *toast = new SystemToast(this);
	toast->setBody(text);
	toast->setPosition(SystemUiPosition::MiddleCenter);
	toast->show();
}

void ApplicationUI::showProgressToast(const QString &title,
		const QString &text) {
	SystemProgressToast *progresstoast = new SystemProgressToast(this);

	progresstoast->setBody(title);
	progresstoast->setProgress(75);
	progresstoast->setStatusMessage(text);
	progresstoast->setState(SystemUiProgressState::Active);
	progresstoast->setPosition(SystemUiPosition::MiddleCenter);
	progresstoast->show();
}

void ApplicationUI::showDialog(const QString &title, const QString &text) {
	SystemDialog *dialog = new SystemDialog(this);
	dialog->setTitle(title);
	dialog->setBody(text);
	dialog->setEmoticonsEnabled(true);
	dialog->show();
}

void ApplicationUI::showProgressDialog(const QString &title,
		const QString &body) {
	progressdialog = new SystemProgressDialog();
	progressdialog->setProgress(-1);
	progressdialog->setState(SystemUiProgressState::Active);
	progressdialog->confirmButton()->setEnabled(false);
	progressdialog->setTitle(title);
	progressdialog->setBody(body);
	progressdialog->show();
}

void ApplicationUI::hideProgressDialog()
{
	if(progressdialog != NULL)
	{
		progressdialog->cancel();
	}
}

// --------------------- INVOCATIONS --------------------- //

void ApplicationUI::invokeSMS(QString number)
{
	InvokeRequest request;
	request.setTarget("sys.pim.text_messaging.composer");
	request.setAction("bb.action.SENDTEXT");
	request.setUri("tel:" + number);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeShare(QString text)
{
	InvokeRequest request;
	request.setMimeType("text/plain");
	request.setAction("bb.action.SHARE");
	request.setData(text.toAscii());
	invokeManager->invoke(request);
}

void ApplicationUI::invokeEmail(QString email, QString subject, QString body) {
	InvokeRequest request;
	request.setTarget("sys.pim.uib.email.hybridcomposer");
	request.setAction("bb.action.SENDEMAIL");
	request.setUri(
			"mailto:" + email + "?subject=" + subject.replace(" ", "%20")
					+ "&body=" + body.replace(" ", "%20"));
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBBWorld(QString appurl) {
	InvokeRequest request;
	request.setMimeType("application/x-bb-appworld");
	request.setAction("bb.action.OPEN");
	request.setUri(appurl);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBrowser(QString url) {
	InvokeRequest request;
	request.setTarget("sys.browser");
	request.setAction("bb.action.OPEN");
	request.setUri(url);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeAddContact(QString number) {
	InvokeRequest request;
	request.setMimeType("application/vnd.blackberry.string.phone");
	request.setTarget("sys.pim.contacts.app");
	request.setAction("bb.action.ADDTOCONTACT");
	request.setData(number.toAscii());
	invokeManager->invoke(request);
}

void ApplicationUI::invokeOpenWithFacebook(QString accountid)
{
	InvokeRequest request;
	request.setTarget("com.rim.bb.app.facebook");
	request.setAction("bb.action.OPEN");

	QVariantMap payload;
	payload["object_type"] = "user";
	payload["object_id"] = accountid;

	request.setMetadata(payload);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeOpenWithTwitter(QString accountid)
{
	InvokeRequest request;
	request.setTarget("com.twitter.urihandler");
	request.setAction("bb.action.VIEW");
	request.setUri("twitter:connect:" + accountid);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeMap(double latitude, double longitude)
{
	qDebug() << latitude << longitude;
}
