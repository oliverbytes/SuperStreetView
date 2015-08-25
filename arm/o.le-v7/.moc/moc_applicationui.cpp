/****************************************************************************
** Meta object code from reading C++ file 'applicationui.hpp'
**
** Created: Sat Oct 26 18:55:40 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/applicationui.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationui.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      18,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
      60,   41,   14,   14, 0x02,
     104,   97,   14,   14, 0x02,
     128,  123,   14,   14, 0x02,
     156,  149,   14,   14, 0x02,
     183,  179,   14,   14, 0x02,
     206,   97,   14,   14, 0x02,
     242,  232,   14,   14, 0x02,
     274,  232,   14,   14, 0x02,
     324,  305,   14,   14, 0x02,
     356,  349,   14,   14, 0x02,
     373,  123,   14,   14, 0x02,
     403,  392,   14,   14, 0x02,
     438,  392,   14,   14, 0x02,
     477,  466,   14,   14, 0x02,
     513,   14,   14,   14, 0x02,
     566,  542,  534,   14, 0x02,
     616,  594,   14,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0onSystemLanguageChanged()\0"
    "email,subject,body\0"
    "invokeEmail(QString,QString,QString)\0"
    "number\0invokeSMS(QString)\0text\0"
    "invokeShare(QString)\0appurl\0"
    "invokeBBWorld(QString)\0url\0"
    "invokeBrowser(QString)\0invokeAddContact(QString)\0"
    "accountid\0invokeOpenWithFacebook(QString)\0"
    "invokeOpenWithTwitter(QString)\0"
    "latitude,longitude\0invokeMap(double,double)\0"
    "volume\0setVolume(float)\0showToast(QString)\0"
    "title,text\0showProgressToast(QString,QString)\0"
    "showDialog(QString,QString)\0title,body\0"
    "showProgressDialog(QString,QString)\0"
    "hideProgressDialog()\0QString\0"
    "objectName,defaultValue\0"
    "getSetting(QString,QString)\0"
    "objectName,inputValue\0setSetting(QString,QString)\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->onSystemLanguageChanged(); break;
        case 1: _t->invokeEmail((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 2: _t->invokeSMS((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->invokeShare((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->invokeBBWorld((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->invokeBrowser((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->invokeAddContact((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->invokeOpenWithFacebook((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->invokeOpenWithTwitter((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->invokeMap((*reinterpret_cast< double(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2]))); break;
        case 10: _t->setVolume((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 11: _t->showToast((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 12: _t->showProgressToast((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 13: _t->showDialog((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 14: _t->showProgressDialog((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 15: _t->hideProgressDialog(); break;
        case 16: { QString _r = _t->getSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 17: _t->setSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 18)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 18;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
