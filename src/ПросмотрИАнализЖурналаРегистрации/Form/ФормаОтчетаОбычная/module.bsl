﻿
Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	ЕстьПрава = Истина;
	Если НЕ ПравоДоступа("Администрирование", Метаданные) Тогда
		Сообщить("Отсутствуют административные права!", СтатусСообщения.Важное);
		ЕстьПрава = Ложь;
	КонецЕсли;
	Если НЕ ПравоДоступа("ЖурналРегистрации", Метаданные) Тогда
		Сообщить("Недостаточно прав для работы с журналом регистрации!", СтатусСообщения.Важное);
		ЕстьПрава = Ложь;
	КонецЕсли;
	Если НЕ ЕстьПрава Тогда 
		Отказ = Истина;
		Возврат;
	КонецЕсли;	
	
	УстановитьНачальныеНастройки();
	
	УстановитьВариантыНастроек();
		
КонецПроцедуры

// Настройки отчета

Процедура УстановитьНачальныеНастройки()
	
	ПараметрПользователь = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Пользователь");
	ПользователиИнфБазы = ПользователиИнформационнойБазы.ПолучитьПользователей();
	СписокПользователейИБ = Новый СписокЗначений;
	Для Каждого Пользователь Из ПользователиИнфБазы Цикл
		СписокПользователейИБ.Добавить(Пользователь.Имя);
	КонецЦикла;
	ПараметрПользователь.Значение = СписокПользователейИБ;
	
	ПараметрИмяПриложения = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ИмяПриложения");
	СписокИменПриложений = Новый СписокЗначений;
	СписокИменПриложений.Добавить("1CV8");
	СписокИменПриложений.Добавить("1CV8C");
	СписокИменПриложений.Добавить("WebClient");
	СписокИменПриложений.Добавить("Designer");
	СписокИменПриложений.Добавить("COMConnection");
	СписокИменПриложений.Добавить("WSConnection");
	СписокИменПриложений.Добавить("BackgroundJob");
	СписокИменПриложений.Добавить("SrvrConsole");
	СписокИменПриложений.Добавить("COMConsole");
	СписокИменПриложений.Добавить("JobScheduler");
	СписокИменПриложений.Добавить("Debugger");
	ПараметрИмяПриложения.Значение = СписокИменПриложений;

КонецПроцедуры

// Варианты отчета

Процедура УстановитьВариантыНастроек()
	
	КП = ЭлементыФормы.ДействияФормы; НоваяКнопка = КП.Кнопки.Вставить(1,"_ВариантыОтчетов", ТипКнопкиКоманднойПанели.Подменю, "Варианты отчетов", ); НовоеДействие = Новый Действие("_СменаВариантаНастройки"); Сч = 1;
	
	Для каждого Настройка Из СхемаКомпоновкиДанных.ВариантыНастроек Цикл
		
		НоваяКнопка = КП.Кнопки._ВариантыОтчетов.Кнопки.Добавить("Вариант"+Строка(Сч), ТипКнопкиКоманднойПанели.Действие, Настройка.Представление, НовоеДействие); Сч = Сч + 1;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура _СменаВариантаНастройки (Элемент)
	
	Для каждого Настройка Из СхемаКомпоновкиДанных.ВариантыНастроек Цикл
		
		Если Элемент.Текст = Настройка.Представление тогда
			
			КомпоновщикНастроек.ЗагрузитьНастройки(Настройка.Настройки);
			
			Прервать;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры


Процедура БлогНажатие(Элемент)
	
	ЗапуститьПриложение("http://www.develplatform.com/");
	
КонецПроцедуры

