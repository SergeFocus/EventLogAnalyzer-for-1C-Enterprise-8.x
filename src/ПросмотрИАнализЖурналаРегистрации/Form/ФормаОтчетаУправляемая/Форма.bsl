﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
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
	
	Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Важность Цикл
		ВажностьПредставление.Добавить(Эл.Ключ, Эл.Значение, Истина);
	КонецЦикла;
	Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.СтатусТранзакции Цикл
		СтатусТранзакцииПредставление.Добавить(Эл.Ключ, Эл.Значение, Истина);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьПредставлениеСобытийОтбора();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки <> Неопределено Тогда
		
		ВыбраннаяВажность =  Настройки.Получить("Отчет.Важность");
		Если ВыбраннаяВажность <> Неопределено Тогда
			КоличествоВыбранных = 0;
			Для Каждого Эл Из ВажностьПредставление Цикл
				Если НЕ ВыбраннаяВажность.НайтиПоЗначению(Эл.Значение) = Неопределено Тогда
					Эл.Пометка = Истина;
					КоличествоВыбранных = КоличествоВыбранных + 1;
				КонецЕсли;
			КонецЦикла;
			Если КоличествоВыбранных = 0 Тогда
				Для Каждого Эл Из ВажностьПредставление Цикл
					Эл.Пометка = Истина;	
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		ВыбранныйСтатусТранзакции =  Настройки.Получить("Отчет.СтатусТранзакции");
		Если ВыбранныйСтатусТранзакции <> Неопределено Тогда
			КоличествоВыбранных = 0;
			Для Каждого Эл Из СтатусТранзакцииПредставление Цикл
				Если НЕ ВыбранныйСтатусТранзакции.НайтиПоЗначению(Эл.Значение) = Неопределено Тогда
					Эл.Пометка = Истина;
					КоличествоВыбранных = КоличествоВыбранных + 1;
				КонецЕсли;
			КонецЦикла;
			Если КоличествоВыбранных = 0 Тогда
				Для Каждого Эл Из СтатусТранзакцииПредставление Цикл
					Эл.Пометка = Истина;	
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		ВыбранныеСеансы =  Настройки.Получить("Отчет.Сеансы");
		Если ВыбранныеСеансы <> Неопределено Тогда
			Отчет.Сеансы.Очистить();
			Для Каждого Эл Из ВыбранныеСеансы Цикл
				СеансыПредставление.Добавить(Эл.Значение, Эл.Представление);
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Состояние("Сохранение настроек", "Выполняется сохранение текущий настроек отчета...", , БиблиотекаКартинок.НастроитьСписок);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыборПериода(Команда)
	
	Диалог = Новый ДиалогРедактированияСтандартногоПериода();
	Диалог.Период.ДатаНачала = Отчет.НачалоПериода;
	Диалог.Период.ДатаОкончания = Отчет.КонецПериода;
	Диалог.Показать(Новый ОписаниеОповещения("ВыборПериодаЗавершение", ЭтаФорма));
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПериодаЗавершение(Период, ДопПараметры) Экспорт

	Если НЕ Период = Неопределено Тогда
		Отчет.НачалоПериода = Период.ДатаНачала;	
		Отчет.КонецПериода = Период.ДатаОкончания;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда, РежимФормированияОтчета = Неопределено)
	
	Если РежимФормированияОтчета = Неопределено Тогда
		Если Отчет.КэшироватьДанные И Отчет.КэшЖурналаРегистрации.Количество() > 0 Тогда
			Отчет.РежимФормированияОтчета = "ТолькоФормированиеОтчета";
		Иначе
			Отчет.РежимФормированияОтчета = "ЖурналРегистрацииИОтчет";	
		КонецЕсли;
	КонецЕсли;
	СкомпоноватьРезультат(РежимКомпоновкиРезультата.Авто);
	ЭтаФорма.Заголовок = "[" + Отчет.ВремяВыполненияПоследнейОперации + " cек.]";
	
КонецПроцедуры

&НаКлиенте
Процедура ВернутьсяКФильтрам(Команда)

	Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ФильтрыЖурналаРегистрации;
	ОсновнаяПанельПриСменеСтраницы(Команда, Элементы.ОсновнаяПанель.ТекущаяСтраница); 
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанныеЖурналаРегистрацииИСформироватьОтчет(Команда)
	
	Состояние("Выполняется получение данных журнала регистрации
			  |и формирование выбранного варианта отчета.
			  |Пожалуйста, подождите...", 
		БиблиотекаКартинок.ЖурналРегистрации);
		
	Отчет.РежимФормированияОтчета = "ЖурналРегистрацииИОтчет";
	Сформировать(Команда, Отчет.РежимФормированияОтчета);
		
	Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ПросмотрИАнализДанных;
	ОсновнаяПанельПриСменеСтраницы(Команда, Элементы.ОсновнаяПанель.ТекущаяСтраница); 
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанныеБезФормированияОтчета(Команда)
	
	Состояние("Получение данных...",, 
		"
		|Выполняется получение данных журнала регистрации
		|Пожалуйста, подождите...", 
		БиблиотекаКартинок.ЖурналРегистрации);
		
	Отчет.РежимФормированияОтчета = "ТолькоЖурналРегистацииОтчет";
	Сформировать(Команда, Отчет.РежимФормированияОтчета);
		
	Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ПросмотрИАнализДанных;
	ОсновнаяПанельПриСменеСтраницы(Команда, Элементы.ОсновнаяПанель.ТекущаяСтраница); 
	
КонецПроцедуры

&НаКлиенте
Процедура ВернутьсяКОтчету(Команда)
	
	Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ПросмотрИАнализДанных;
	ОсновнаяПанельПриСменеСтраницы(Команда, Элементы.ОсновнаяПанель.ТекущаяСтраница); 

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура РезультатВыбор(Элемент, Область, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекОбласть = Элементы.Результат.ТекущаяОбласть;
	Если ТекОбласть = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПолученныеДанныеРасшифровки = ПолучитьЗначениеРасшифровкиНаСервере(ТекОбласть.Расшифровка);
	Если НЕ ПолученныеДанныеРасшифровки.ПолеРасшифровки = Неопределено
		И НЕ ПолученныеДанныеРасшифровки.ЗначениеРасшифровки = Неопределено Тогда
		ПоказатьПредупреждение(, ПолученныеДанныеРасшифровки.ЗначениеРасшифровки,, "Расшифровка");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьЗначениеРасшифровкиНаСервере(ИндексРашсифровки)
	
	СтруктураРезультат = Новый Структура;
	СтруктураРезультат.Вставить("ПолеРасшифровки", Неопределено);
	СтруктураРезультат.Вставить("ЗначениеРасшифровки", Неопределено);	
	
	ДанныеРасшифровкиОтчета = ПолучитьИзВременногоХранилища(ДанныеРасшифровки);
	ЭлементРасшифровки = ДанныеРасшифровкиОтчета.Элементы.Получить(ИндексРашсифровки);
	Если ТипЗнч(ЭлементРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		ПоляРашсифровки = ЭлементРасшифровки.ПолучитьПоля();
		Если ПоляРашсифровки.Количество() = 1 Тогда
			ПолеРасшифровки = ПоляРашсифровки.Получить(0);
			СтруктураРезультат.ПолеРасшифровки = ПолеРасшифровки.Поле;
			Если ТипЗнч(ПолеРасшифровки.Значение) = Тип("Строка")
				ИЛИ ТипЗнч(ПолеРасшифровки.Значение) = Тип("Дата") 
				ИЛИ ТипЗнч(ПолеРасшифровки.Значение) = Тип("Булево")
				ИЛИ ТипЗнч(ПолеРасшифровки.Значение) = Тип("Число")
				ИЛИ ТипЗнч(ПолеРасшифровки.Значение) = Тип("УникальныйИдентификатор") Тогда
				СтруктураРезультат.ЗначениеРасшифровки = ПолеРасшифровки.Значение;
			ИначеЕсли ТипЗнч(ПолеРасшифровки.Значение) = Тип("Неопределено") Тогда
				СтруктураРезультат.ПолеРасшифровки = Неопределено;		
				СтруктураРезультат.ЗначениеРасшифровки = Неопределено;
			ИначеЕсли ТипЗнч(ПолеРасшифровки.Значение) = Тип("УровеньЖурналаРегистрации") Тогда		
				СтруктураРезультат.ЗначениеРасшифровки = Строка(ПолеРасшифровки.Значение);
			КонецЕсли;
		КонецЕсли;
	ИначеЕсли ТипЗнч(ЭлементРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхГруппировка") Тогда
		
	КонецЕсли;
	
	Возврат СтруктураРезультат;
	
КонецФункции

&НаКлиенте
Процедура РезультатОбработкаДополнительнойРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНастройкиТекущейСтраницы()
	
	Если Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ФильтрыЖурналаРегистрации Тогда
		Элементы.ПолучитьДанныеЖурналаРегистрации.КнопкаПоУмолчанию = Истина;
	ИначеЕсли Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.ПросмотрИАнализДанных Тогда
		Элементы.Сформировать.КнопкаПоУмолчанию = Истина;		
	КонецЕсли;	
	Элементы.ВернутьсяКОтчету.Видимость = (Отчет.КэшЖурналаРегистрации.Количество() > 0);
	
КонецПроцедуры

&НаКлиенте
Процедура ОсновнаяПанельПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	УстановитьНастройкиТекущейСтраницы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаНачалаВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	
	Если Элемент.Имя = "КолонкиЖурналаРегистрации" Тогда
		
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.КолонкиЖурналаРегистрации Цикл
			ЗначенияВыбора.Добавить(Эл.Значение, Эл.Значение);
		КонецЦикла;
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.КолонкиЖурналаРегистрации);
		ПараметрыФормы.Вставить("ВыборИзДереваЗначений", Истина);
		ПараметрыФормы.Вставить("СтроковойРазделительКатегорий", ".");
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";

	ИначеЕсли Элемент.Имя = "События" Тогда
		
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Событие Цикл
			ЗначенияВыбора.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ЗначенияВыбора.СортироватьПоПредставлению();
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.События);
		ПараметрыФормы.Вставить("ВыборИзДереваЗначений", Истина);
		ПараметрыФормы.Вставить("СтроковойРазделительКатегорий", ".");
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";
		
	ИначеЕсли Элемент.Имя = "РабочиеСерверы" Тогда
		
		ПараметрыФормы = Новый Структура;
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.РабочийСервер Цикл
			ЗначенияВыбора.Добавить(Эл, Эл);
		КонецЦикла;
		ЗначенияВыбора.СортироватьПоПредставлению();
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.РабочиеСерверы);
		ПараметрыФормы.Вставить("ВыборИзДереваЗначений", Истина);
		ПараметрыФормы.Вставить("СтроковойРазделительКатегорий", ".");
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";
		
	ИначеЕсли Элемент.Имя = "ОсновныеIPПорты" Тогда
		
		ПараметрыФормы = Новый Структура;
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ОсновнойIPПорт Цикл
			ЗначенияВыбора.Добавить(Эл, Эл);
		КонецЦикла;
		ЗначенияВыбора.СортироватьПоПредставлению();
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.ОсновныеIPПорты);
		ПараметрыФормы.Вставить("ВыборИзДереваЗначений", Истина);
		ПараметрыФормы.Вставить("СтроковойРазделительКатегорий", ".");
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";
		
	ИначеЕсли Элемент.Имя = "ВспомогательныеIPПорты" Тогда
		
		ПараметрыФормы = Новый Структура;
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ВспомогательныйIPПорт Цикл
			ЗначенияВыбора.Добавить(Эл, Эл);
		КонецЦикла;
		ЗначенияВыбора.СортироватьПоПредставлению();
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.ВспомогательныеIPПорты);
		ПараметрыФормы.Вставить("ВыборИзДереваЗначений", Истина);
		ПараметрыФормы.Вставить("СтроковойРазделительКатегорий", ".");		
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";
		
	ИначеЕсли Элемент.Имя = "Компьютеры" Тогда
		
		КоллекцияДоступныхЗначений = Новый СписокЗначений;
		КоллекцияДоступныхЗначенийМассив = Отчет.КэшДоступныхЗначенийОтборов.Компьютер;
		КоллекцияВыбранныхЗначений = Отчет.Компьютеры;		
		Для Каждого Эл ИЗ КоллекцияДоступныхЗначенийМассив Цикл
			КоллекцияДоступныхЗначений.Добавить(Эл, Эл);	
		КонецЦикла;
		КоллекцияДоступныхЗначений.СортироватьПоПредставлению();		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ВсеЗначения", КоллекцияДоступныхЗначений);
		ПараметрыФормы.Вставить("МоиЗначения", КоллекцияВыбранныхЗначений);
		ИмяФормыВыбора = "ФормаВыбораЗначенийОтбора";
		
	ИначеЕсли Элемент.Имя = "Метаданные" Тогда
		
		НачальноеЗначениеВыбора = Неопределено;
		ФильтрПоСсылочнымМетаданным = Новый СписокЗначений;
		ФильтрПоОбъектамМетаданных = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.Метаданные Цикл
			ФильтрПоОбъектамМетаданных.Добавить(Эл.Ключ, Эл.Значение);
			ФильтрПоСсылочнымМетаданным.Добавить(Эл.Ключ);
			Если НачальноеЗначениеВыбора = Неопределено Тогда
				НачальноеЗначениеВыбора = Эл.Ключ;	
			КонецЕсли;
			ИмяМетаданныхВерхнегоУровня = ПолучитьКорневоеИмяМетаданных(Эл.Ключ, Ложь);
			Если ФильтрПоСсылочнымМетаданным.НайтиПоЗначению(ИмяМетаданныхВерхнегоУровня) = Неопределено Тогда
				ФильтрПоСсылочнымМетаданным.Добавить(ИмяМетаданныхВерхнегоУровня);
			КонецЕсли;
		КонецЦикла;
		
		УникальныйИдентификаторИсточник = ЭтаФорма.УникальныйИдентификатор;
		
		ПередаваемыеПараметры = Новый Структура;
		ПередаваемыеПараметры.Вставить("ВыборЕдинственного", Ложь);
		ПередаваемыеПараметры.Вставить("НачальноеЗначениеВыбора", НачальноеЗначениеВыбора);
		ПередаваемыеПараметры.Вставить("КоллекцииВыбираемыхОбъектовМетаданных", ФильтрПоСсылочнымМетаданным);
		ПередаваемыеПараметры.Вставить("УникальныйИдентификаторИсточник", УникальныйИдентификаторИсточник);
		ПередаваемыеПараметры.Вставить("ФильтрПоОбъектамМетаданных", ФильтрПоОбъектамМетаданных);
		ПередаваемыеПараметры.Вставить("ВыбранныеОбъектыМетаданных", Отчет.Метаданные);
		ИмяФормыВыбора = "ВыборОбъектовМетаданных";
		
	ИначеЕсли Элемент.Имя = "Комментарий" Тогда
		
		ОповещениеОЗавершении = Новый ОписаниеОповещения("КомментарийНачалоВыбораЗавершение", ЭтаФорма);
		РедактируемыйКомментарий = Элементы.Комментарий.ТекстРедактирования;
		ПоказатьВводСтроки(ОповещениеОЗавершении, РедактируемыйКомментарий, "Отбор по комментарию", , Истина);
		ИмяФормыВыбора = Неопределено;
		
	ИначеЕсли Элемент.Имя = "Пользователи" Тогда
		
		КоллекцияДоступныхЗначений = Новый СписокЗначений;
		КоллекцияДоступныхЗначенийСоответствие = Отчет.КэшДоступныхЗначенийОтборов.Пользователь;
		КоллекцияВыбранныхЗначений = Отчет.Пользователи;
		
		Для Каждого Эл ИЗ КоллекцияДоступныхЗначенийСоответствие Цикл
			КоллекцияДоступныхЗначений.Добавить(Строка(Эл.Ключ), Эл.Значение);	
		КонецЦикла;
		КоллекцияДоступныхЗначений.СортироватьПоПредставлению();
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ВсеЗначения", КоллекцияДоступныхЗначений);
		ПараметрыФормы.Вставить("МоиЗначения", КоллекцияВыбранныхЗначений);
		ИмяФормыВыбора = "ФормаВыбораЗначенийОтбора";
		
	ИначеЕсли Элемент.Имя = "Приложения" Тогда
		
		ПараметрыФормы = Новый Структура;
		ЗначенияВыбора = Новый СписокЗначений;
		Для Каждого Эл Из Отчет.КэшДоступныхЗначенийОтборов.ИмяПриложения Цикл
			ЗначенияВыбора.Добавить(Эл.Ключ, Эл.Значение);
		КонецЦикла;
		ЗначенияВыбора.СортироватьПоПредставлению();
		ПараметрыФормы.Вставить("ДоступныеЗначенияОтбора", ЗначенияВыбора);
		ПараметрыФормы.Вставить("ВыбранныеЗначенияОтбора", Отчет.Приложения);
		ИмяФормыВыбора = "ФормаВыбораЗначенийИзСписка";
		
	Иначе
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяФормыВыбора) Тогда
		ОткрытьФорму("ВнешнийОтчет.ПросмотрИАнализЖурналаРегистрации.Форма." + ИмяФормыВыбора, ПараметрыФормы, Элемент, УникальныйИдентификатор); 
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораСписка(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если Элемент.Имя = "Приложения" Тогда
		Отчет.Приложения.Очистить();
		КоличествоВыбранныхЭлементов = 0;
		ВыбранныеЗначения = ВыбранноеЗначение.ПолучитьЭлементы();
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				КоличествоВыбранныхЭлементов = КоличествоВыбранныхЭлементов + 1;	
			КонецЕсли;
		КонецЦикла;
		
		ВсеВыбраны = (КоличествоВыбранныхЭлементов = Отчет.КэшДоступныхЗначенийОтборов.ИмяПриложения.Количество());
		Если НЕ ВсеВыбраны Тогда
			Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
				Если Эл.Пометка Тогда
					Отчет.Приложения.Добавить(Эл.Значение, Эл.Представление);	
				КонецЕсли;
			КонецЦикла;
		Иначе
			Отчет.Приложения.Очистить();	
		КонецЕсли;
	ИначеЕсли Элемент.Имя = "КолонкиЖурналаРегистрации" Тогда
		Отчет.КолонкиЖурналаРегистрации.Очистить();
		КоличествоВыбранныхЭлементов = 0;
		ВыбранныеЗначения = ВыбранноеЗначение.ПолучитьЭлементы();
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				КоличествоВыбранныхЭлементов = КоличествоВыбранныхЭлементов + 1;	
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				Отчет.КолонкиЖурналаРегистрации.Добавить(Эл.Значение, Эл.Представление);	
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли Элемент.Имя = "События" Тогда
		Отчет.События.Очистить();
		Для Каждого Эл Из ВыбранноеЗначение.ПолучитьЭлементы() Цикл
			ПодчиненныеЭлементыДерева = Эл.ПолучитьЭлементы();
			Если Эл.Пометка Тогда
				Если ПодчиненныеЭлементыДерева.Количество() = 0 Тогда
					Отчет.События.Добавить(Эл.Значение, Эл.Представление);	
				Иначе
					ДобавитьОтборПоМетаданнымИзСтрокиДерева(ПодчиненныеЭлементыДерева, Отчет.События, Строка(Эл.Значение), Строка(Эл.Представление));		
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		Если Отчет.События.Количество() = Отчет.КэшДоступныхЗначенийОтборов.Событие.Количество() Тогда
			Отчет.События.Очистить();
		КонецЕсли;
		ОбновитьПредставлениеСобытийОтбора();
	ИначеЕсли Элемент.Имя = "РабочиеСерверы" Тогда
		Отчет.РабочиеСерверы.Очистить();
		КоличествоВыбранныхЭлементов = 0;
		ВыбранныеЗначения = ВыбранноеЗначение.ПолучитьЭлементы();
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				КоличествоВыбранныхЭлементов = КоличествоВыбранныхЭлементов + 1;	
			КонецЕсли;
		КонецЦикла;
		
		ВсеВыбраны = (КоличествоВыбранныхЭлементов = Отчет.КэшДоступныхЗначенийОтборов.РабочийСервер.Количество());
		Если НЕ ВсеВыбраны Тогда
			Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
				Если Эл.Пометка Тогда
					Отчет.РабочиеСерверы.Добавить(Эл.Значение, Эл.Представление);	
				КонецЕсли;
			КонецЦикла;
		Иначе
			Отчет.РабочиеСерверы.Очистить();	
		КонецЕсли;
	ИначеЕсли Элемент.Имя = "ОсновныеIPПорты" Тогда
		Отчет.РабочиеСерверы.Очистить();
		КоличествоВыбранныхЭлементов = 0;
		ВыбранныеЗначения = ВыбранноеЗначение.ПолучитьЭлементы();
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				КоличествоВыбранныхЭлементов = КоличествоВыбранныхЭлементов + 1;	
			КонецЕсли;
		КонецЦикла;
		
		ВсеВыбраны = (КоличествоВыбранныхЭлементов = Отчет.КэшДоступныхЗначенийОтборов.ОсновнойIPПорт.Количество());
		Если НЕ ВсеВыбраны Тогда
			Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
				Если Эл.Пометка Тогда
					Отчет.ОсновныеIPПорты.Добавить(Эл.Значение, Эл.Представление);	
				КонецЕсли;
			КонецЦикла;
		Иначе
			Отчет.ОсновныеIPПорты.Очистить();	
		КонецЕсли;
	ИначеЕсли Элемент.Имя = "ВспомогательныеIPПорты" Тогда
		Отчет.ВспомогательныеIPПорты.Очистить();
		КоличествоВыбранныхЭлементов = 0;
		ВыбранныеЗначения = ВыбранноеЗначение.ПолучитьЭлементы();
		Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
			Если Эл.Пометка Тогда
				КоличествоВыбранныхЭлементов = КоличествоВыбранныхЭлементов + 1;	
			КонецЕсли;
		КонецЦикла;
		
		ВсеВыбраны = (КоличествоВыбранныхЭлементов = Отчет.КэшДоступныхЗначенийОтборов.ВспомогательныйIPПорт.Количество());
		Если НЕ ВсеВыбраны Тогда
			Для Каждого Эл ИЗ ВыбранныеЗначения Цикл
				Если Эл.Пометка Тогда
					Отчет.ВспомогательныеIPПорты.Добавить(Эл.Значение, Эл.Представление);	
				КонецЕсли;
			КонецЦикла;
		Иначе
			Отчет.ВспомогательныеIPПорты.Очистить();	
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораПодбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если Элемент.Имя = "Пользователи" Тогда
		Отчет.Пользователи.Очистить();
		Для Каждого Эл ИЗ ВыбранноеЗначение Цикл
			Отчет.Пользователи.Добавить(Эл.Значение, Эл.Представление);	
		КонецЦикла;
	ИначеЕсли Элемент.Имя = "Компьютеры" Тогда
		Отчет.Компьютеры.Очистить();
		Для Каждого Эл ИЗ ВыбранноеЗначение Цикл
			Отчет.Компьютеры.Добавить(Эл.Значение, Эл.Представление);	
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПредставлениеСобытийОтбора()
	
	СобытияПредставление.Очистить();
	Для Каждого Эл Из Отчет.События Цикл
		СобытияПредставление.Добавить(Эл.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВажностьПриИзменении(Элемент)
	
	Отчет.Важность.Очистить();
	КоличествоВыбранных = 0;
	Для Каждого Эл Из ВажностьПредставление Цикл
		Если Эл.Пометка Тогда
			Отчет.Важность.Добавить(Эл.Значение, Эл.Представление);
			КоличествоВыбранных = КоличествоВыбранных + 1;
		КонецЕсли;
	КонецЦикла;
	Если Отчет.КэшДоступныхЗначенийОтборов.Важность.Количество() = КоличествоВыбранных Тогда
		Отчет.Важность.Очистить();	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтатусТранзакцииПриИзменении(Элемент)
	
	Отчет.СтатусТранзакции.Очистить();
	КоличествоВыбранных = 0;
	Для Каждого Эл Из СтатусТранзакцииПредставление Цикл
		Если Эл.Пометка Тогда
			Отчет.СтатусТранзакции.Добавить(Эл.Значение, Эл.Представление);
			КоличествоВыбранных = КоличествоВыбранных + 1;
		КонецЕсли;
	КонецЦикла;
	Если Отчет.КэшДоступныхЗначенийОтборов.СтатусТранзакции.Количество() = КоличествоВыбранных Тогда
		Отчет.СтатусТранзакции.Очистить();	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СеансыПриИзменении(Элемент)
	
	Отчет.Сеансы.Очистить();
	КоличествоВыбранных = 0;
	Для Каждого Эл Из СеансыПредставление Цикл
		Отчет.Сеансы.Добавить(Эл.Значение, Эл.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СобытияОчистка(Элемент, СтандартнаяОбработка)
	
	Отчет.События.Очистить();
	
КонецПроцедуры

#КонецОбласти

#Область Служебные

// Функция "расщепляет" строку на подстроки, используя заданный 
//	разделитель. Разделитель может иметь любую длину. 
//	Если в качестве разделителя задан пробел, рядом стоящие пробелы 
//	считаются одним разделителем, а ведущие и хвостовые пробелы параметра Стр 
//	игнорируются. 
//	Например, 
//	РазложитьСтрокуВМассивПодстрок(",ку,,,му", ",") возвратит массив значений из пяти элементов, 
//	три из которых - пустые строки, а 
//	РазложитьСтрокуВМассивПодстрок(" ку му", " ") возвратит массив значений из двух элементов 
// 
//	Параметры: 
//	Стр - строка, которую необходимо разложить на подстроки. 
//	Параметр передается по значению. 
//	Разделитель - строка-разделитель, по умолчанию - запятая. 
// 
// 
//	Возвращаемое значение: 
//	массив значений, элементы которого - подстроки 
// 
&НаКлиентеНаСервереБезКонтекста
Функция РазложитьСтрокуВМассивПодстрок(Знач Стр, Разделитель = ".") Экспорт 
	
	МассивСтрок = Новый Массив(); 
	Если Разделитель = " " Тогда 
		Стр = СокрЛП(Стр); 
		Пока Истина Цикл 
			Поз = Найти(Стр,Разделитель); 
			Если Поз=0 Тогда 
				МассивСтрок.Добавить(Стр); 
				Возврат МассивСтрок; 
			КонецЕсли; 
			МассивСтрок.Добавить(Лев(Стр,Поз-1)); 
			Стр = СокрЛ(Сред(Стр,Поз)); 
		КонецЦикла; 
	Иначе 
		ДлинаРазделителя = СтрДлина(Разделитель); 
		Пока Истина Цикл 
			Поз = Найти(Стр,Разделитель); 
			Если Поз=0 Тогда 
				МассивСтрок.Добавить(Стр); 
				Возврат МассивСтрок; 
			КонецЕсли; 
			МассивСтрок.Добавить(Лев(Стр,Поз-1)); 
			Стр = Сред(Стр,Поз+ДлинаРазделителя); 
		КонецЦикла; 
	КонецЕсли; 
	
КонецФункции // глРазложить

Функция ПолучитьКорневоеИмяМетаданных(Знач ИмяМетаданныхИсходное, МножественноеНаОдиночное = Истина)
		
	СоответствиеЗамены = Новый Соответствие;
	СоответствиеЗамены.Вставить("Подсистема", "Подсистемы");
	СоответствиеЗамены.Вставить("ОбщийМодуль", "ОбщиеМодули");
	СоответствиеЗамены.Вставить("ПараметрСеанса", "ПараметрыСеанса");
	СоответствиеЗамены.Вставить("Роль", "Роли");
	СоответствиеЗамены.Вставить("ПланОбмена", "ПланыОбмена");
	СоответствиеЗамены.Вставить("КритерийОтбора", "КритерииОтбора");
	СоответствиеЗамены.Вставить("ПодпискаНаСобытие", "ПодпискиНаСобытия");
	СоответствиеЗамены.Вставить("РегламентнеЗадание", "РегламентныеЗадания");
	СоответствиеЗамены.Вставить("ФункциональнаяОпция", "ФункциональныеОпции");
	СоответствиеЗамены.Вставить("ПараметрФункциональнойОпции", "ПараметрыФункциональныхОпций");
	СоответствиеЗамены.Вставить("ХранилищеНастроек", "ХранилищаНастроек");
	СоответствиеЗамены.Вставить("ОбщаяФорма", "ОбщиеФормы");
	СоответствиеЗамены.Вставить("ОбщаяКоманда", "ОбщиеКоманды");
	СоответствиеЗамены.Вставить("ГруппаКоманд", "ГруппыКоманд");
	СоответствиеЗамены.Вставить("Интерфейс", "Интерфейсы");
	СоответствиеЗамены.Вставить("ОбщийМакет", "ОбщиеМакеты");
	СоответствиеЗамены.Вставить("ОбщаяКартинка", "ОбщиеКартинки");
	СоответствиеЗамены.Вставить("ПакетXDTO", "ПакетыXDTO");
	СоответствиеЗамены.Вставить("WebСервис", "WebСервисы");
	СоответствиеЗамены.Вставить("WSСсылка", "WSСсылки");
	СоответствиеЗамены.Вставить("Стиль", "Стили");
	СоответствиеЗамены.Вставить("Язык", "Языки");	
	СоответствиеЗамены.Вставить("Константа", "Константы");
	СоответствиеЗамены.Вставить("Справочник", "Справочники");
	СоответствиеЗамены.Вставить("Документ", "Документы");
	СоответствиеЗамены.Вставить("ЖурналДокументов", "ЖурналыДокументов");
	СоответствиеЗамены.Вставить("Перечисление", "Перечисления");
	СоответствиеЗамены.Вставить("Отчет", "Отчеты");
	СоответствиеЗамены.Вставить("Обработка", "Обработки");
	СоответствиеЗамены.Вставить("ПланВидовХарактеристик", "ПланыВидовХарактеристик");
	СоответствиеЗамены.Вставить("ПланСчетов", "ПланыСчетов");
	СоответствиеЗамены.Вставить("ПланВидовРасчета", "ПланыВидовРасчета");
	СоответствиеЗамены.Вставить("РегистрСведений", "РегистрыСведений");
	СоответствиеЗамены.Вставить("РегистрНакопления", "РегистрыНакопления");
	СоответствиеЗамены.Вставить("РегистрБухгалтерии", "РегистрыБухгалтерии");
	СоответствиеЗамены.Вставить("РегистрРасчета", "РегистрыРасчета");
	СоответствиеЗамены.Вставить("БизнесПроцесс", "БизнесПроцессы");
	СоответствиеЗамены.Вставить("Задача", "Задачи"); 		
	
	Для Каждого Эл Из СоответствиеЗамены Цикл
		Если МножественноеНаОдиночное Тогда
			Если Найти(ИмяМетаданныхИсходное, Эл.Значение) > 0 Тогда
				ИмяМетаданныхИсходное = СтрЗаменить(ИмяМетаданныхИсходное, Эл.Значение, Эл.Ключ);
				Прервать;
			КонецЕсли;
		Иначе
			Если Найти(ИмяМетаданныхИсходное, Эл.Ключ) > 0 Тогда
				ИмяМетаданныхИсходное = СтрЗаменить(ИмяМетаданныхИсходное, Эл.Ключ, Эл.Значение);
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	ЧастиИмениМетаданных = РазложитьСтрокуВМассивПодстрок(ИмяМетаданныхИсходное);
	Если ЧастиИмениМетаданных.Количество() > 0 Тогда
		Возврат ЧастиИмениМетаданных.Получить(0);
	Иначе
		Возврат ИмяМетаданныхИсходное;
	КонецЕсли;

КонецФункции

&НаКлиенте
Процедура ДобавитьОтборПоМетаданнымИзСтрокиДерева(ПодчиненныеЭлементыДерева, СписокОтборов, Знач ТекущееЗначениеСтрока, Знач ТекущееПредставлениеСтрока)	
	
	Для Каждого Эл Из ПодчиненныеЭлементыДерева Цикл
		ТекущееЗначениеСтрокаДерева = ТекущееЗначениеСтрока + "." + Эл.Значение;
		ТекущееПредставлениеСтрокаДерева = ТекущееПредставлениеСтрока + "." + Эл.Представление;
		ПодчиненныеЭлементыСтрокиДерева = Эл.ПолучитьЭлементы();
		Если Эл.Пометка Тогда
			Если ПодчиненныеЭлементыСтрокиДерева.Количество() = 0 Тогда
				Отчет.События.Добавить(ТекущееЗначениеСтрокаДерева, ТекущееПредставлениеСтрокаДерева);	
			Иначе
				ДобавитьОтборПоМетаданнымИзСтрокиДерева(ПодчиненныеЭлементыСтрокиДерева, Отчет.События, Строка(Эл.Значение), Строка(Эл.Представление));		
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
