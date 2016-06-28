﻿
&НаКлиенте
Процедура ОбновитьДоступныеЗначенияОтборовНаКлиенте() 
	
	МассивОбрабатываемыхВидовНастроек = Новый Массив;
	МассивОбрабатываемыхВидовНастроек.Добавить("Настройки");
		
	Для Каждого ВидНастройки Из МассивОбрабатываемыхВидовНастроек Цикл
		
		ТекущиеНастройкиСКД = Отчет.КомпоновщикНастроек[ВидНастройки];
		ТекущиеНастройкиОтборов = ТекущиеНастройкиСКД.Отбор;
		ТекущиеДоступныеПоляОтборов = ТекущиеНастройкиОтборов.ДоступныеПоляОтбора.Элементы;
		
		// Имя приложения
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("ИмяПриложения");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ИмяПриложения Цикл
			СписокОтбор.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Уровень журнала регистрации
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("Уровень");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Уровень Цикл
			СписокОтбор.Добавить(Эл.Значение, Эл.Представление);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Имя пользователя
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("ИмяПользователя");
		СписокИменПриложенийОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Пользователь Цикл
			СписокИменПриложенийОтбор.Добавить(Эл.Значение, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокИменПриложенийОтбор;
		
		// Пользователь
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("Пользователь");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Пользователь Цикл
			СписокОтбор.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Компьютер
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("Компьютер");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Компьютер Цикл
			СписокОтбор.Добавить(Эл, Эл);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Событие
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("Событие");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Событие Цикл
			СписокОтбор.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Метаданные
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("Метаданные");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Метаданные Цикл
			СписокОтбор.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Статус транзакции
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("СтатусТранзакции");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.СтатусТранзакции Цикл
			СписокОтбор.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;

		// Рабочий сервер
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("РабочийСервер");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.РабочийСервер Цикл
			СписокОтбор.Добавить(Эл, Эл);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;

		// Рабочий сервер
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("РабочийСервер");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.РабочийСервер Цикл
			СписокОтбор.Добавить(Эл, Эл);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;

		// Основной IP-порт
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("ОсновнойIPПорт");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ОсновнойIPПорт Цикл
			СписокОтбор.Добавить(Эл, Эл);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;
		
		// Вспомогательный IP-порт
		ПолеОтбора = ТекущиеДоступныеПоляОтборов.Найти("ВспомогательныйIPПорт");
		СписокОтбор = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ВспомогательныйIPПорт Цикл
			СписокОтбор.Добавить(Эл, Эл);
		КонецЦикла;
		ПолеОтбора.ДоступныеЗначения = СписокОтбор;

	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();	
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();	
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДоступныеЗначенияОтборовНаСервере() 
	
	ОбъектОтчета = РеквизитФормыВЗначение("Отчет");
	ПутьМетаданныхОтчета = ОбъектОтчета.Метаданные().ПолноеИмя();
	ОбъектОтчета.ОбновитьДоступныеЗначенияОтборов();
	ЗначениеВРеквизитФормы(ОбъектОтчета, "Отчет");
	
	ПользовательскиеНастройкиБылиОбновленыНаСервере = Истина
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьДоступныеЗначенияОтборовНаКлиенте();
	УстановитьВидимостьНастроекФильтровЖурналаРегистрации();
	
	ПодключитьОбработчикОжидания("СинхронизацияДоступныхЗначенийОтборовПользовательскихНастроек", 1, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьНастроекФильтровЖурналаРегистрации()
	
	Для Каждого Эл Из Элементы Цикл
		Попытка
			Если ТипЗнч(Эл) = Тип("ПолеФормы") Тогда
				Если Найти(Эл.Заголовок, "(фильтр)") > 0 Тогда
					Если Эл.Видимость = Истина Тогда
						Эл.Видимость = Ложь;	
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		Исключение
			// При возникновении ошибки продолжаем работу, 
			// т.к. сбой при установке видимости элемента отбора не влияет
			// на работоспособность отчета и его настроек
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СинхронизацияДоступныхЗначенийОтборовПользовательскихНастроек() Экспорт
	
	Если ПользовательскиеНастройкиБылиОбновленыНаСервере Тогда
		ОбновитьДоступныеЗначенияОтборовНаКлиенте();
		УстановитьВидимостьНастроекФильтровЖурналаРегистрации();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
		
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииВариантаНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойВариантаНаСервере(Настройки)
		
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеВариантаНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииПользовательскихНастроекНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойПользовательскихНастроекНаСервере(Настройки)
		
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Настройки)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ОбновитьДоступныеЗначенияОтборовНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	Если ВыборСделан Тогда
		СтруктураПараметров = Новый Структура;
		СтруктураПараметров.Вставить("Вариант", Отчет.КомпоновщикНастроек.Настройки);
		СтруктураПараметров.Вставить("ИсточникДоступныхНастроек", Отчет.КомпоновщикНастроек.ПолучитьИсточникДоступныхНастроек());
		СтруктураПараметров.Вставить("КлючВарианта", ЭтаФорма.КлючТекущегоВарианта);
		СтруктураПараметров.Вставить("КлючПользовательскихНастроек", ЭтаФорма.КлючТекущихПользовательскихНастроек);
		СтруктураПараметров.Вставить("Отбор", Новый Структура());
		СтруктураПараметров.Вставить("ПользовательскиеНастройки", Отчет.КомпоновщикНастроек.ПользовательскиеНастройки);
		СтруктураПараметров.Вставить("ПредставлениеВарианта", ЭтаФорма.ПредставлениеТекущегоВарианта);
		СтруктураПараметров.Вставить("ПредставлениеПользовательскихНастроек", ЭтаФорма.ПредставлениеТекущихПользовательскихНастроек);
		СтруктураПараметров.Вставить("Расшифровка", ЭтаФорма.КлючТекущегоВарианта);
		СтруктураПараметров.Вставить("СформироватьПриОткрытии", Ложь);
		СтруктураПараметров.Вставить("ФиксированныеНастройки", Отчет.КомпоновщикНастроек.ФиксированныеНастройки);
		ОповеститьОВыборе(СтруктураПараметров);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	ВыборСделан = Истина;
	Закрыть();
	
КонецПроцедуры
