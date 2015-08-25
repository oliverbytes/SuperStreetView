#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/system/SystemProgressDialog>
#include <bb/system/InvokeManager>

using bb::system::InvokeManager;
using bb::system::SystemProgressDialog;

namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;

        namespace system
		{
			class InvokeManager;
		}
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }
    Q_INVOKABLE void invokeEmail(QString email, QString subject, QString body);
	Q_INVOKABLE void invokeSMS(QString number);
	Q_INVOKABLE void invokeShare(QString text);
	Q_INVOKABLE void invokeBBWorld(QString appurl);
	Q_INVOKABLE void invokeBrowser(QString url);
	Q_INVOKABLE void invokeAddContact(QString number);
	Q_INVOKABLE void invokeOpenWithFacebook(QString accountid);
	Q_INVOKABLE void invokeOpenWithTwitter(QString accountid);
	Q_INVOKABLE void invokeMap(double latitude, double longitude);

	Q_INVOKABLE void setVolume(float volume);

	Q_INVOKABLE void showToast(const QString &text);
	Q_INVOKABLE void showProgressToast(const QString &title, const QString &text);
	Q_INVOKABLE void showDialog(const QString &title, const QString &text);
	Q_INVOKABLE void showProgressDialog(const QString &title, const QString &body);
	Q_INVOKABLE void hideProgressDialog();
	Q_INVOKABLE QString getSetting(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE void setSetting(const QString &objectName, const QString &inputValue);

private slots:
    void onSystemLanguageChanged();

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    InvokeManager* invokeManager;
    SystemProgressDialog* progressdialog;

};

#endif /* ApplicationUI_HPP_ */
