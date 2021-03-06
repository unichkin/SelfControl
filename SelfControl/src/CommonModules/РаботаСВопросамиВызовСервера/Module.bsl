////////////////////////////////////////////////////////////////////////////////
// Конфигурация "Самоконтроль"
// Авторское право (с) 2021, Уничкин Р. А.

// Разрешается повторное распространение и использование как в виде исходника так и в двоичной форме,
// с модификациями или без, при соблюдении следующих условий:
// - При повторном распространении исходного кода должно оставаться указанное выше уведомление об авторском
//   праве, этот список условий и нижеследующий отказ от гарантий.
// - При повторном распространении двоичного кода должно воспроизводиться указанное выше уведомление об
//   авторском праве, этот список условий и нижеследующий отказ от гарантий в документации и/или в других
//   материалах, поставляемых при распространении.
//
// ЭТО ПРОГРАММА ПРЕДОСТАВЛЕНА БЕСПЛАТНО ДЕРЖАТЕЛЯМИ АВТОРСКИХ ПРАВ И/ИЛИ ДРУГИМИ СТОРОНАМИ "КАК ОНА ЕСТЬ"
// БЕЗ КАКОГО-ЛИБО ВИДА ГАРАНТИЙ, ВЫРАЖЕННЫХ ЯВНО ИЛИ ПОДРАЗУМЕВАЕМЫХ, ВКЛЮЧАЯ, НО НЕ ОГРАНИЧИВАЯСЬ ИМИ,
// ПОДРАЗУМЕВАЕМЫЕ ГАРАНТИИ КОММЕРЧЕСКОЙ ЦЕННОСТИ И ПРИГОДНОСТИ ДЛЯ КОНКРЕТНОЙ ЦЕЛИ. НИ В КОЕМ СЛУЧАЕ,
// ЕСЛИ НЕ ТРЕБУЕТСЯ СООТВЕТСТВУЮЩИМ ЗАКОНОМ, ИЛИ НЕ УСТАНОВЛЕНО В УСТНОЙ ФОРМЕ, НИ ОДИН ДЕРЖАТЕЛЬ АВТОРСКИХ
// ПРАВ И НИ ОДНО ДРУГОЕ ЛИЦО, КОТОРОЕ МОЖЕТ ИЗМЕНЯТЬ И/ИЛИ ПОВТОРНО РАСПРОСТРАНЯТЬ ПРОГРАММУ, КАК БЫЛО
// РАЗРЕШЕНО ВЫШЕ, НЕ ОТВЕТСТВЕННЫ ПЕРЕД ВАМИ ЗА УБЫТКИ, ВКЛЮЧАЯ ЛЮБЫЕ ОБЩИЕ, СЛУЧАЙНЫЕ, СПЕЦИАЛЬНЫЕ ИЛИ
// ПОСЛЕДОВАВШИЕ УБЫТКИ, ПРОИСТЕКАЮЩИЕ ИЗ ИСПОЛЬЗОВАНИЯ ИЛИ НЕВОЗМОЖНОСТИ ИСПОЛЬЗОВАНИЯ ПРОГРАММЫ (ВКЛЮЧАЯ,
// НО НЕ ОГРАНИЧИВАЯСЬ ПОТЕРЕЙ ДАННЫХ, ИЛИ ДАННЫМИ, СТАВШИМИ НЕПРАВИЛЬНЫМИ, ИЛИ ПОТЕРЯМИ ПРИНЕСЕННЫМИ ИЗ-ЗА
// ВАС ИЛИ ТРЕТЬИХ ЛИЦ, ИЛИ ОТКАЗОМ ПРОГРАММЫ РАБОТАТЬ СОВМЕСТНО С ДРУГИМИ ПРОГРАММАМИ), ДАЖЕ ЕСЛИ ТАКОЙ
// ДЕРЖАТЕЛЬ ИЛИ ДРУГОЕ ЛИЦО БЫЛИ ИЗВЕЩЕНЫ О ВОЗМОЖНОСТИ ТАКИХ УБЫТКОВ.

#Область ПрограммныйИнтерфейс

// Полный номер вопроса в иерархии
//
// Параметры:
//  Вопрос - СправочникСсылка.Вопросы
//
// Возвращаемое значение:
//  Строка
//
Функция ПолныйНомерВопроса(Знач Вопрос) Экспорт

	Источник = Вопрос;

	Номера = Новый Массив;

	Пока Истина Цикл
		Если НЕ ЗначениеЗаполнено(Источник) Тогда
			Прервать;
		КонецЕсли;
		Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Источник, "РеквизитДопУпорядочивания, Родитель, ЭтоГруппа, ЭтоГруппаТестов");
		Источник = Реквизиты.Родитель;
		Если Реквизиты.ЭтоГруппа И НЕ Реквизиты.ЭтоГруппаТестов Тогда
			Продолжить;
		КонецЕсли;
		Номера.Вставить(0, Реквизиты.РеквизитДопУпорядочивания);
	КонецЦикла;

	Результат = СтрСоединить(Номера, ".");
	Возврат Результат;

КонецФункции

// Проверить орфографию текста вопроса и вариантов ответов
//
// Параметры:
//  ОбъектВопроса - СправочникСсылка.Вопросы, ДанныеФормыКоллекция
//
// Возвращаемое значение:
//  Булево
//
Функция ПроверитьОрфографию(Знач ОбъектВопроса) Экспорт
	Результат = ОбщегоНазначенияКлиентСервер.НовыйРезультатПроверки();
	РезультатПроверкиТекста = ПроверкаОрфографииВызовСервера.ПроверкаОрфографии(ОбъектВопроса.ТекстВопроса);

	ОбщегоНазначенияКлиентСервер.ДобавитьРезультатПроверки(Результат
		, РезультатПроверкиТекста
		, "Ошибки при проверке текста вопроса: " + Символы.ПС);

	Для каждого СтрокаТЧ Из ОбъектВопроса.Ответы Цикл
		РезультатПроверкиОтвета = ПроверкаОрфографииВызовСервера.ПроверкаОрфографии(СтрокаТЧ.ТекстОтвета);

		ОбщегоНазначенияКлиентСервер.ДобавитьРезультатПроверки(Результат
			, РезультатПроверкиОтвета
			, "Ошибки при проверке ответа №" + СтрокаТЧ.НомерСтроки + ": " + Символы.ПС);
	КонецЦикла;

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции



#КонецОбласти
