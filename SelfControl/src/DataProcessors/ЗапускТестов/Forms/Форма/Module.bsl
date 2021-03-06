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

#Область ОписаниеПеременных

&НаСервере
Перем мТекущийОбъектНаСервере;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Параметры.Свойство("СессияТестирования", СессияТестирования);
	УмнаяПеремоткаВключена = Истина;
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)

	Если СессияЗаполнена() Тогда
		Настройки.Удалить("СессияТестирования");
		Настройки.Вставить("ОтборВопросов", СессияТестирования.ОтборВопросов);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьПометкуРежимаПеремотки();
	ПриОткрытииНаСервере();

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)

	Действия = ДействияПроверкиЗаполнения();
	Если ДействиеПроверкиЗаполнения = Действия.НачалоТестирования Тогда
		ПроверяемыеРеквизиты.Добавить("ОтборВопросов");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИмяСобытия = РаботаСДиалогамиКлиент.СобытияОповещений().ЗаписьВопроса Тогда
		Если Источник = ТекущийВопрос Тогда
			ЗагрузитьВопрос();

		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПеремешиватьВопросыПриИзменении(Элемент)
	ПеремешиватьВопросыПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ГруппаВариантОтветаИПояснениеПриСменеСтраницы(Элемент, ТекущаяСтраница)
	Если ТекущаяСтраница = Элементы.ГруппаПояснение Тогда
		ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);
		ОписаниеВопроса = ТаблицаВопросов.Получить(ИндексТекВопроса);
		Если НЕ ОписаниеВопроса.ПояснениеПросмотрено Тогда
			ОписаниеВопроса.ПояснениеПросмотрено = Истина;
			ЗаписатьПросмотрПояснения();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПеремешиватьОтветыПриИзменении(Элемент)

	Если ЗначениеЗаполнено(ТекущийВопрос) Тогда
		ЗагрузитьВопрос();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИндикация

&НаКлиенте
Процедура ИндикацияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ЧастиСтроки = РазбитьСтроку(Поле.Имя, "_");
	ТипЧисло = Новый ОписаниеТипов("Число");
	ИндексВопроса = ТипЧисло.ПривестиЗначение(ЧастиСтроки.Правая);
	ЗагрузитьВопросПоИндексу(ИндексВопроса);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыВариантыОтветов

&НаКлиенте
Процедура ВариантыОтветовОтветПользователяПриИзменении(Элемент)

	ТекСтрока = Элементы.ВариантыОтветов.ТекущаяСтрока;
	Если ТекСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;

	СвойстваВопроса(ЭтотОбъект).НомерОтвета =
		Элементы.ВариантыОтветов.ТекущиеДанные.НомерОтвета;

	Для каждого СтрокаТаблицы Из ВариантыОтветов Цикл
		Если СтрокаТаблицы.ПолучитьИдентификатор() = ТекСтрока Тогда
			Продолжить;
		КонецЕсли;

		СтрокаТаблицы.ОтветПользователя = Ложь;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Проверить(Команда)
	Поиск = Новый Структура("ОтветПользователя", Истина);
	СтрокиТаблицы = ВариантыОтветов.НайтиСтроки(Поиск);
	Если НЕ ЗначениеЗаполнено(СтрокиТаблицы) Тогда
		ПоказатьПредупреждение(, "Не выбран вариант ответа");
		Возврат;
	КонецЕсли;

	Если НЕ УВопросаЗаданОтвет() Тогда
		ТекстВопроса = "В текущем вопросе не указан верный вариант ответа. " +
		"Установить текущие значения в качестве такового (также обновляется пояснение)?";
		Если Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет Тогда
			Возврат;
		КонецЕсли;
		УстановитьТекущиеОтветыВВопрос();
	КонецЕсли;

	ПроверитьРезультатНаСервере();

	Если НЕ ЭтоПоследнийВопрос(ЭтотОбъект) Тогда
		СвойстваВопроса = СвойстваВопроса(ЭтотОбъект);
		Если СвойстваВопроса.ЭтоВерныйОтвет Тогда
			ЗагрузитьСледующийВопрос();
		Иначе
			ПерейтиКПояснению();
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НачатьПродолжитьТестирование(Команда)
	ДействиеПроверкиЗаполнения = ДействияПроверкиЗаполнения().НачалоТестирования;
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;

	НачатьСессиюТестирования();
КонецПроцедуры

&НаКлиенте
Процедура НачатьТестированиеПоОшибкам(Команда)
	ДействиеПроверкиЗаполнения = ДействияПроверкиЗаполнения().НачалоТестирования;
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;

	НачатьСессиюТестированияПоОшибкамТекущейСессии();
КонецПроцедуры

&НаКлиенте
Процедура СледующийВопрос(Команда)
	ЗагрузитьСледующийВопрос();
КонецПроцедуры

&НаКлиенте
Процедура ПредыдущийВопрос(Команда)
	ЗагрузитьПредыдущийВопрос();
КонецПроцедуры

&НаКлиенте
Процедура ЗакончитьТестирование(Команда)
	СброситьСессиюТестирования();
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьТекущийВопрос(Команда)
	ПараметрыОткрытия = Новый Структура("Ключ", ТекущийВопрос);
	ОткрытьФорму("Справочник.Вопросы.ФормаОбъекта"
		, ПараметрыОткрытия
		, ЭтотОбъект
		,
		,
		,
		,
		, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьРежимПеремотки(Команда)
	УмнаяПеремоткаВключена = НЕ УмнаяПеремоткаВключена;
	УстановитьПометкуРежимаПеремотки();
	УстановитьСвойстваКнопокРулеткиВопросов();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Сервис

&НаКлиентеНаСервереБезКонтекста
Функция ДействияПроверкиЗаполнения()

	Результат = Новый Структура;
	Результат.Вставить("НачалоТестирования", "НачалоТестирования");

	Возврат Результат;

КонецФункции

&НаСервере
Функция ЦветФонаВопроса(СвойстваВопроса)
	Если СвойстваВопроса.Проверен Тогда
		Цвета = Цвета();
		Результат = ?(СвойстваВопроса.ЭтоВерныйОтвет, Цвета.ВерныйОтвет, Цвета.НеверныйОтвет);

	ИначеЕсли СвойстваВопроса.Вопрос = ТекущийВопрос Тогда
		Результат = WebЦвета.СветлоНебесноГолубой;

	Иначе
		Результат = Новый Цвет();
	КонецЕсли;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область Диалог

&НаКлиенте
Процедура ПерейтиКПояснению()

	Если НЕ ПояснениеДоступно(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;

	Элементы.ГруппаВариантОтветаИПояснение.ТекущаяСтраница = Элементы.ГруппаПояснение;

КонецПроцедуры

&НаСервере
Функция СессияЗавершена()
	СессияЗавершена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СессияТестирования, "Завершена");
	Возврат СессияЗавершена = Истина;
КонецФункции

&НаСервере
Процедура НастроитьФормуПоЗавершеннойСессии()

	Если НЕ СессияЗаполнена() Тогда
		Возврат;
	КонецЕсли;

	Если НЕ СессияЗавершена() Тогда
		Возврат;
	КонецЕсли;

	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаРезультатТеста;

КонецПроцедуры

&НаСервере
Процедура ВывестиРезультатТестирования()
	Справочники.СессииТестирования.ВывестиРезультатТестирования(СессияТестирования, РезультатТеста);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкуРежимаПеремотки()
	Элементы.ИзменитьРежимПеремотки.Пометка = УмнаяПеремоткаВключена;
КонецПроцедуры

&НаСервере
Процедура ВключитьВыключитьОформлениеВариантовОтветов(Флаг)

	ИменаНастроек = Новый Массив;
	ИменаНастроек.Добавить("ВерныйОтвет");
	ИменаНастроек.Добавить("НеверныйОтвет");

	Для каждого ПредставлениеУО Из ИменаНастроек Цикл
		ЭлемУО = НайтиПоПредставлению(УсловноеОформление, ПредставлениеУО);
		ЭлемУО.Использование = Флаг;
	КонецЦикла;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция Цвета()

	Результат = Новый Структура;
	Результат.Вставить("ВерныйОтвет", Новый Цвет(0, 255, 0));
	Результат.Вставить("НеверныйОтвет", Новый Цвет(255, 0, 0));

	Возврат Результат;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция НайтиПоПредставлению(Колекция, Представление)

	Для каждого Элем Из Колекция.Элементы Цикл
		Если Элем.Представление = Представление Тогда
			Возврат Элем;
		КонецЕсли;
	КонецЦикла;

КонецФункции

&НаСервере
Процедура УстановитьСвойстваКнопокРулеткиВопросов()

	ОписаниеПозиции = ОписаниеПозиции(ЭтотОбъект);
	ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);

	КнопкаПред = Элементы.ПредыдущийВопрос;
	УстановитьСвойстваКнопкиРулетки(КнопкаПред, ИндексТекВопроса, ОписаниеПозиции.Пред);

	КнопкаСлед = Элементы.СледующийВопрос;
	УстановитьСвойстваКнопкиРулетки(КнопкаСлед, ИндексТекВопроса, ОписаниеПозиции.След);

КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваКнопкиРулетки(Кнопка, ИндексТекВопроса, ОписаниеПозиции)
	ВидыПозиций = ВидыПозиций();
	Если ОписаниеПозиции.Вид = ВидыПозиций.След Тогда
		Дельта = ОписаниеПозиции.Индекс - ИндексТекВопроса;

	ИначеЕсли ОписаниеПозиции.Вид = ВидыПозиций.Пред Тогда
		Дельта = ИндексТекВопроса - ОписаниеПозиции.Индекс;

	Иначе
		ВызватьИсключение "Сбой: не определен вид позиции";

	КонецЕсли;

	Если Дельта <> 1 Тогда
		НомерВопроса = ОписаниеПозиции.Индекс + 1;
		ЗаголовокКнопки = "" + НомерВопроса;
	КонецЕсли;

	Если ЗначениеЗаполнено(ЗаголовокКнопки) Тогда
		Кнопка.Заголовок = ЗаголовокКнопки;
		Отображение = ОтображениеКнопки.КартинкаИТекст;
	Иначе
		Отображение = ОтображениеКнопки.Картинка;
	КонецЕсли;

	Если Кнопка.Отображение <> Отображение Тогда
		Кнопка.Отображение = Отображение;
	КонецЕсли;

	СвойстваВопроса = СвойстваВопроса(ЭтотОбъект, ОписаниеПозиции.Индекс);
	Кнопка.ЦветФона = ЦветФонаВопроса(СвойстваВопроса);
	Команды[Кнопка.ИмяКоманды].Подсказка = СвойстваВопроса.Представление;

КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоФлагуПроверкиВопроса()
	Проверен = СвойстваВопроса(ЭтотОбъект).Проверен;
	Элементы.Проверить.Доступность = НЕ Проверен;
	Элементы.ВариантыОтветовОтветПользователя.Доступность = НЕ Проверен;
	ВключитьВыключитьОформлениеВариантовОтветов(Проверен);
КонецПроцедуры

#КонецОбласти

#Область ВызовСервера

&НаСервере
Процедура ПеремешиватьВопросыПриИзмененииНаСервере()
	Константы.ПеремешиватьВопросы.Установить(ПеремешиватьВопросы);
	ТаблицаВопросов.Очистить();
	НачатьСессиюТестирования();

КонецПроцедуры

#КонецОбласти

#Область Условия

&НаКлиентеНаСервереБезКонтекста
Функция СвойстваВопроса(Форма, Индекс = Неопределено)
	Если Индекс = Неопределено Тогда
		Индекс = ИндексТекВопроса(Форма);
	КонецЕсли;
	СтрокаТаблицы = Форма.ТаблицаВопросов.Получить(Индекс);
	Возврат СтрокаТаблицы;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ЭтоПоследнийВопрос(Форма)
	Индекс = ИндексТекВопроса(Форма);
	Результат = Форма.ТаблицаВопросов.Количество() = Индекс + 1;
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция УВопросаЗаданОтвет()

	Поиск = Новый Структура("ЭтоВерныйОтвет", Истина);
	СтрокиОтветов = ВариантыОтветов.НайтиСтроки(Поиск);
	Возврат ЗначениеЗаполнено(СтрокиОтветов);

КонецФункции

#КонецОбласти

#Область Индикация

&НаСервере
Процедура ЗаполнитьИндикацию()
	Индикация.Очистить();
	ОбновитьКолонкиИндикатора();
	Индикатор = Индикация.Добавить();
	КолСтрок = ТаблицаВопросов.Количество();
	Для НомерСтроки = 1 По КолСтрок Цикл
		Индекс = НомерСтроки - 1;
		ИмяПоля = ИмяКолонкиИндикатора(Индекс);
		Индикатор[ИмяПоля] = НомерСтроки;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ОбновитьКолонкиИндикатора()

	ТабИндикации = РеквизитФормыВЗначение("Индикация");
	КолКолонок = ТабИндикации.Колонки.Количество();
	КолКонечное = ТаблицаВопросов.Количество();

	ИменаУдалемых = Новый Массив;
	ДобавляемыеРеквизиты = Новый Массив;

	ТипЧисло = Новый ОписаниеТипов("Число");
	Для НомерКолонки = 1 По КолКонечное Цикл
		Если КолКолонок >= НомерКолонки Тогда
			Продолжить;
		КонецЕсли;

		Индекс = НомерКолонки - 1;
		ИмяКолонки =  ИмяКолонкиИндикатора(Индекс);
		РеквизитФормы = Новый РеквизитФормы(ИмяКолонки, ТипЧисло, "Индикация");
		ДобавляемыеРеквизиты.Добавить(РеквизитФормы);
	КонецЦикла;

	Для НомерОбратный = - КолКолонок По - КолКонечное Цикл
		НомерКолонки = - НомерОбратный;
		Если НомерКолонки > КолКонечное Тогда
			Индекс = НомерКолонки - 1;
			ИмяКолонки =  ИмяКолонкиИндикатора(Индекс);
			ИменаУдалемых.Добавить("Индикация." + ИмяКолонки);
		КонецЕсли;
	КонецЦикла;

	ИзменятьРеквизиты = ЗначениеЗаполнено(ИменаУдалемых) ИЛИ ЗначениеЗаполнено(ДобавляемыеРеквизиты);
	Если ИзменятьРеквизиты Тогда
		ИзменитьРеквизиты(ДобавляемыеРеквизиты, ИменаУдалемых);
	КонецЕсли;

	Для каждого ИмяЭлемента Из ИменаУдалемых Цикл
		ЭлемФормы = Элементы[ИмяЭлемента];
		Элементы.Удалить(ЭлемФормы);
	КонецЦикла;

	ИменаДобавленных = Новый Соответствие;
	Для каждого РеквизитФормы Из ДобавляемыеРеквизиты Цикл
		ИменаДобавленных.Вставить(РеквизитФормы.Имя, Истина);
	КонецЦикла;

	ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);
	Для НомерКолонки = 1 По КолКонечное Цикл
		Индекс = НомерКолонки - 1;
		ИмяКолонки = ИмяКолонкиИндикатора(Индекс);

		ЭтоНовыйРеквизит = ИменаДобавленных.Получить(ИмяКолонки) = Истина;
		Если ЭтоНовыйРеквизит Тогда
			ЭлемФормы = Элементы.Добавить(ИмяКолонки, Тип("ПолеФормы"), Элементы.Индикация);
			ЭлемФормы.Вид = ВидПоляФормы.ПолеНадписи;
			ЭлемФормы.ПутьКДанным = "Индикация." + ИмяКолонки;
			ЭлемФормы.ГиперссылкаЯчейки = Истина;
			ЭлемФормы.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
		Иначе
			ЭлемФормы = Элементы[ИмяКолонки];
		КонецЕсли;

		Если Индекс = 0 Тогда
			ШрифтЭлементаИндикации = ЭлемФормы.Шрифт;
		КонецЕсли;

		ОформитьЭлементИндикатора(Индекс, ИндексТекВопроса);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция ИмяКолонкиИндикатора(Индекс)
	Результат = "В_" + Индекс;
	Возврат Результат;
КонецФункции

&НаСервере
Функция ЭлементИндикатора(Индекс)
	ИмяКолонки = ИмяКолонкиИндикатора(Индекс);
	Результат = Элементы[ИмяКолонки];
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ОбновитьОформлениеИндикаторов()
	ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);
	КолКонечное = ТаблицаВопросов.Количество();
	Для НомерКолонки = 1 По КолКонечное Цикл
		Индекс = НомерКолонки - 1;
		ОформитьЭлементИндикатора(Индекс, ИндексТекВопроса);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ОформитьЭлементИндикатора(Знач Индекс, Знач ИндексТекВопроса = Неопределено)

	Элем = ЭлементИндикатора(Индекс);
	СвойстваВопроса = СвойстваВопроса(ЭтотОбъект, Индекс);
	Элем.ЦветФона = ЦветФонаВопроса(СвойстваВопроса);
	Если ИндексТекВопроса = Неопределено Тогда
		ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);
	КонецЕсли;

	ДлинаСтрокиНомера = СтрДлина(Формат(Индекс + 1, "ЧГ="));
	ЭтоТекВопрос = ИндексТекВопроса = Индекс;
	Если ЭтоТекВопрос Тогда
		Элем.Шрифт = Новый Шрифт(ШрифтЭлементаИндикации, , 14, Истина);
		Элем.Ширина = Макс(3, ДлинаСтрокиНомера + 3);
		Элементы.Индикация.ТекущийЭлемент = Элем;
	Иначе
		Элем.Шрифт = Новый Шрифт;
		Элем.Ширина = Макс(2, ДлинаСтрокиНомера + 1);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область Процессы

&НаСервере
Процедура ПриОткрытииНаСервере()
	Если СессияЗаполнена() Тогда
		Если СессияЗавершена() Тогда
			НастроитьФормуПоЗавершеннойСессии();
		Иначе
			ВосстановитьСессиюТестированияПриОткрытии();
		КонецЕсли;
		ВывестиРезультатТестирования();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура НачатьСессиюТестированияПоОшибкамТекущейСессии()
	ТаблицаВопросов.Очистить();
	СформироватьНовыйОтборВопросовПоОшибкамТекущейСессииИЗатеретьТекущуюСессию();
	НачатьСессиюТестирования();
КонецПроцедуры

&НаСервере
Процедура ВосстановитьСессиюТестированияПриОткрытии()
	ЗагрузитьВопросыСессииТестирования();
	НачатьСессиюТестирования();
КонецПроцедуры

&НаСервере
Процедура НачатьСессиюТестирования()
	ОбновитьСессиюТестирования();

	ЗагружатьСледующий = Истина;
	Если ЗначениеЗаполнено(ТекущийВопрос) Тогда
		Если Справочники.СессииТестирования.ВопросПринадлежитСессии(СессияТестирования, ТекущийВопрос) Тогда
			ЗагрузитьВопрос();
			ЗагружатьСледующий = Ложь;
		Иначе
			ТекущийВопрос = Неопределено;
		КонецЕсли;
	КонецЕсли;

	Если ЗагружатьСледующий Тогда
		ЗагрузитьСледующийВопрос();
	КонецЕсли;

	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаТестирование;

КонецПроцедуры

&НаСервере
Процедура СброситьСессиюТестирования()
	ТаблицаВопросов.Очистить();
	Справочники.СессииТестирования.ЗавершитьСессию(СессияТестирования);
	СессияТестирования = Неопределено;
	ТекущийВопрос = Неопределено;
КонецПроцедуры

&НаСервере
Процедура ПроверитьРезультатНаСервере()
	ИндексТекВопроса = ИндексТекВопроса(ЭтотОбъект);

	ЗаписатьОтвет(ИндексТекВопроса);
	НастроитьФормуПоФлагуПроверкиВопроса();
	НастроитьФормуПоЗавершеннойСессии();
	ВывестиРезультатТестирования();
	ОформитьЭлементИндикатора(ИндексТекВопроса, ИндексТекВопроса);
	ОбновитьСтатус();

КонецПроцедуры

#КонецОбласти

#Область ЗаписьРезультатов

&НаСервере
Процедура ЗаписатьПросмотрПояснения()
	Если ЕстьОтветПользователя() Тогда
		Возврат;
	КонецЕсли;
	Справочники.СессииТестирования.ЗаписатьПросмотрПояснения(СессияТестирования, ТекущийВопрос);
КонецПроцедуры

&НаСервере
Функция ЕстьОтветПользователя()
	Поиск = Новый Структура;
	Поиск.Вставить("ОтветПользователя", Истина);
	СтрокиОтветов = ВариантыОтветов.НайтиСтроки(Поиск);
	Результат = ЗначениеЗаполнено(СтрокиОтветов);
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ЗаписатьОтвет(ИндексТекВопроса)
	Поиск = Новый Структура;
	Поиск.Вставить("ОтветПользователя", Истина);
	Поиск.Вставить("ЭтоВерныйОтвет", Истина);
	СтрокиОтветов = ВариантыОтветов.НайтиСтроки(Поиск);
	ЭтоВерныйОтвет = ЗначениеЗаполнено(СтрокиОтветов);

	СвойстваВопроса = СвойстваВопроса(ЭтотОбъект, ИндексТекВопроса);
	СвойстваВопроса.ЭтоВерныйОтвет = ЭтоВерныйОтвет;
	СвойстваВопроса.Проверен = Истина;

	Справочники.СессииТестирования.ЗаписатьСостояние(СессияТестирования, ТекущийВопрос, Истина, ЭтоВерныйОтвет);
	ОбновитьСвойстваТекущегоВопросаИзСвойствСессии();
КонецПроцедуры

#КонецОбласти

#Область ЗаполнениеДанных

&НаСервере
Процедура УстановитьТекущиеОтветыВВопрос()

	ВопросОбъект = ТекущийВопрос.ПолучитьОбъект();
	Поиск = Новый Структура("ЭтоВерныйОтвет", Истина);
	СтрокиОтветов = ВариантыОтветов.НайтиСтроки(Поиск);

	Для каждого СтрокаПравильногоОтвета Из СтрокиОтветов Цикл
		СтрокаОтвета = ВопросОбъект.Ответы.Найти(СтрокаПравильногоОтвета.ТекстОтвета, "ТекстОтвета");
		СтрокаОтвета.ЭтоВерныйОтвет = Истина;
	КонецЦикла;

	ВопросОбъект.Записать();

КонецПроцедуры

&НаСервере
Процедура ОбновитьСессиюТестирования()

	Если ЗначениеЗаполнено(ТаблицаВопросов) Тогда
		Возврат;
	КонецЕсли;

	УстановитьЗаголовокФормыНаСервере();
	Если СессияЗаполнена() Тогда
		Если ПеремешиватьВопросы Тогда
			Справочники.СессииТестирования.ПеремешатьВопросы(СессияТестирования);
		Иначе
			Справочники.СессииТестирования.СортироватьВопросы(СессияТестирования);
		КонецЕсли;
	Иначе
		СессияТестирования = Справочники.СессииТестирования.НоваяСессия(ОтборВопросов);
	КонецЕсли;
	ЗагрузитьВопросыСессииТестирования();

КонецПроцедуры

&НаСервере
Процедура СформироватьНовыйОтборВопросовПоОшибкамТекущейСессииИЗатеретьТекущуюСессию()

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СессииТестированияВопросы.Вопрос
		|ИЗ
		|	Справочник.СессииТестирования.Вопросы КАК СессииТестированияВопросы
		|ГДЕ
		|	СессииТестированияВопросы.Ссылка = &Ссылка
		|	И СессииТестированияВопросы.ЭтоВерныйОтвет = ЛОЖЬ";

	Запрос.УстановитьПараметр("Ссылка", СессияТестирования);
	РезультатЗапроса = Запрос.Выполнить();
	СписокВопросов = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Вопрос");
	Если НЕ ЗначениеЗаполнено(СписокВопросов) Тогда
		ВызватьИсключение "Нет вопросов с ошибками в текущей сессии";
	КонецЕсли;

	СброситьСессиюТестирования();

	НаимНовогоОтбора = "По ошибкам сессии (" + СписокВопросов.Количество() + ")";
	ОтборВопросов = Справочники.ОтборыВопросов.НайтиСоздатьОтборПоСписку(СписокВопросов, НаимНовогоОтбора);

КонецПроцедуры

&НаСервере
Функция СессияЗаполнена()

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СессииТестирования.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.СессииТестирования КАК СессииТестирования
		|ГДЕ
		|	СессииТестирования.Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка", СессияТестирования);

	РезультатЗапроса = Запрос.Выполнить();

	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();

	Результат = Выборка.Ссылка = СессияТестирования;
	Возврат Результат;

КонецФункции

&НаСервере
Процедура ЗагрузитьВопросыСессииТестирования()
	ТаблицаВопросов.Очистить();

	Для каждого СтрокаТЧ Из СессияТестирования.Вопросы Цикл
		СтрокаТаблицы = ТаблицаВопросов.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицы, СтрокаТЧ);
	КонецЦикла;

	Для каждого СтрокаТаблицы Из ТаблицаВопросов Цикл
		СтрокаТаблицы.Представление = ПредставлениеВопроса(СтрокаТаблицы);
	КонецЦикла;

	ЗаполнитьИндикацию();
	ОбновитьСтатус();

КонецПроцедуры

&НаСервере
Функция ПредставлениеВопроса(СтрокаТаблицы)

	ШаблонПорядка = "Вопрос №%1 из %2 (%3)";
	Результат = СтрШаблон(ШаблонПорядка
		, ТаблицаВопросов.Индекс(СтрокаТаблицы) + 1
		, ТаблицаВопросов.Количество()
		, РаботаСВопросамиВызовСервера.ПолныйНомерВопроса(СтрокаТаблицы.Вопрос));

	Возврат Результат;

КонецФункции

&НаСервере
Процедура УстановитьЗаголовокФормыНаСервере()

	Если ЗначениеЗаполнено(ОтборВопросов) Тогда
		Постфикс = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОтборВопросов, "Наименование");
	Иначе
		Постфикс = "<Отбор не задан>";
	КонецЕсли;

	Заголовок = "Тест: " + Постфикс;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьВопросПоИндексу(Индекс)

	ТекущийВопрос = ТаблицаВопросов.Получить(Индекс).Вопрос;
	ЗагрузитьВопрос();

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСледующийВопрос()

	Если НЕ ЗначениеЗаполнено(ТаблицаВопросов) Тогда
		ВызватьИсключение "Не заполнены вопросы";
	КонецЕсли;

	ОписаниеПозицииСлед = ОписаниеПозицииСлед(ЭтотОбъект);
	ТекущийВопрос = ТаблицаВопросов.Получить(ОписаниеПозицииСлед.Индекс).Вопрос;
	ЗагрузитьВопрос();

КонецПроцедуры

&НаСервере
Процедура ОбновитьСвойстваТекущегоВопросаИзСвойствСессии()

	Если НЕ ЗначениеЗаполнено(ТекущийВопрос) Тогда
		Возврат;
	КонецЕсли;

	СвойстваТекущегоВопроса = СвойстваВопроса(ЭтотОбъект);
	СвойстваИзСессии = СессияТестирования.Вопросы.Найти(ТекущийВопрос, "Вопрос");
	СвойстваТекущегоВопроса.ДлительностьОтвета = СвойстваИзСессии.ДлительностьОтвета;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьПредыдущийВопрос()

	Если НЕ ЗначениеЗаполнено(ТаблицаВопросов) Тогда
		ВызватьИсключение "Не заполнены вопросы";
	КонецЕсли;

	ОписаниеПозицииПред = ОписаниеПозицииПред(ЭтотОбъект);
	ТекущийВопрос = ТаблицаВопросов.Получить(ОписаниеПозицииПред.Индекс).Вопрос;
	ЗагрузитьВопрос();

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьВопрос()

	СписокСтрокОтветов = Новый Массив;
	Для каждого СтрокаТаблицы Из ТекущийВопрос.Ответы Цикл
		СписокСтрокОтветов.Добавить(СтрокаТаблицы);
	КонецЦикла;

	СвойстваТекущегоВопроса = СвойстваВопроса(ЭтотОбъект);
	Если ПеремешиватьОтветы И
		НЕ ТекущийВопрос.ЗапретитьПеремешивание
		И НЕ СвойстваТекущегоВопроса.Проверен Тогда
		СписокСтрокОтветов = ОбщегоНазначения.ПеремешатьЗначения(СписокСтрокОтветов);
	КонецЕсли;

	ОбновитьРеквизитыОтветов(СписокСтрокОтветов, СвойстваТекущегоВопроса.НомерОтвета);

	Пояснение = ТекущийВопрос.Пояснение.Получить();
	НастройкиОформленияКлиентСервер.ОформитьВопрос(Пояснение);
	Элементы.ГруппаПояснение.Доступность = ПояснениеДоступно(ЭтотОбъект);
	Элементы.ГруппаВариантОтветаИПояснение.ТекущаяСтраница = Элементы.ГруппаТекстВариантаОтвета;

	УстановитьСвойстваКнопокРулеткиВопросов();
	Элементы.ДекорацияПредставлениеПорядкаВопроса.Заголовок = СвойстваТекущегоВопроса.Представление;
	НастроитьФормуПоФлагуПроверкиВопроса();

	Если НЕ СвойстваТекущегоВопроса.Проверен Тогда
		Справочники.СессииТестирования.ЗаписатьВремяПросмотра(СессияТестирования, ТекущийВопрос);
	КонецЕсли;

	ОбновитьОформлениеИндикаторов();

КонецПроцедуры

&НаСервере
Процедура ОбновитьСтатус()

	ДлительностьВсего = ТаблицаВопросов.Итог("ДлительностьОтвета");
	Поиск = Новый Структура("Проверен", Истина);
	СтрокиПроверенных = ТаблицаВопросов.НайтиСтроки(Поиск);
	КолПроверенных = СтрокиПроверенных.Количество();

	Если КолПроверенных = 0 Тогда
		ДлительностьСред = 0;
	Иначе
		ДлительностьСред = ДлительностьВсего / КолПроверенных;
	КонецЕсли;

	Всего = ТаблицаВопросов.Количество();
	КолОставшихся = Всего - КолПроверенных;
	ДлительностьСредОставшихся = КолОставшихся * ДлительностьСред;

	ЧастиФорматСтроки = Новый Массив();
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, "Всего: ");

	ВсегоВремя = ОбщегоНазначенияКлиентСервер.ПредставлениеДлительностиВСекундах(ДлительностьВсего);
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, ВсегоВремя, WebЦвета.Синий);
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, "; Примерно осталось: ");

	СредВремя = ОбщегоНазначенияКлиентСервер.ПредставлениеДлительностиВСекундах(ДлительностьСредОставшихся);
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, СредВремя, WebЦвета.Синий);

	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, "; Среднее время ответа: ");

	СредОтвета = ОбщегоНазначенияКлиентСервер.ПредставлениеДлительностиВСекундах(ДлительностьСред);
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, СредОтвета, WebЦвета.Синий);

	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, ". Ответы:");

	КолВерных = 0;
	КолНеверных = 0;
	Для Каждого СтрокаТаблицы Из СтрокиПроверенных Цикл
		Если СтрокаТаблицы.ЭтоВерныйОтвет Тогда
			КолВерных = КолВерных + 1;
		Иначе
			КолНеверных = КолНеверных + 1;
		КонецЕсли;
	КонецЦикла;
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, КолВерных, WebЦвета.ТемноЗеленый);
	Если КолНеверных > 0 Тогда
		ДобавитьЧастьФСтроки(ЧастиФорматСтроки, " + ");
		ДобавитьЧастьФСтроки(ЧастиФорматСтроки, КолНеверных, WebЦвета.Красный);
		ДобавитьЧастьФСтроки(ЧастиФорматСтроки, " = ");
		ДобавитьЧастьФСтроки(ЧастиФорматСтроки, КолВерных + КолНеверных);
	КонецЕсли;

	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, " из ");
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, Всего);
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, ", осталось: ");
	ДобавитьЧастьФСтроки(ЧастиФорматСтроки, КолОставшихся);

	Статус = Новый ФорматированнаяСтрока(ЧастиФорматСтроки);
КонецПроцедуры

&НаСервере
Процедура ДобавитьЧастьФСтроки(Приемник, Значение, Цвет = Неопределено)
	Текст = "" + Значение;
	Если Цвет = Неопределено Тогда
		Приемник.Добавить(Текст);
	Иначе
		ФСтрока = Новый ФорматированнаяСтрока(Текст, , Цвет);
		Приемник.Добавить(ФСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПояснениеДоступно(Форма)
	Результат = ЗначениеЗаполнено(Форма.Пояснение.Элементы);
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ОбновитьРеквизитыОтветов(СписокСтрокОтветов, НомерОтветаПользователя)

	ВариантыОтветов.Очистить();
	Счетчик = 0;
	Для каждого СтрокаТаблицы Из СписокСтрокОтветов Цикл
		Счетчик = Счетчик + 1;

		СтрокаВарианта = ВариантыОтветов.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаВарианта, СтрокаТаблицы);
		СтрокаВарианта.НомерОтвета = СтрокаТаблицы.НомерСтроки;
		Если СтрокаВарианта.НомерОтвета = НомерОтветаПользователя Тогда
			СтрокаВарианта.ОтветПользователя = Истина;
		КонецЕсли;

		Если ТекущийВопрос.ЗапретитьПеремешивание Тогда
			СтрокаВарианта.ТекстОтвета = "" + Счетчик + ") " + СтрокаВарианта.ТекстОтвета;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область СборДанных

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеПозиции(Форма)

	ИндексТекВопроса = ИндексТекВопроса(Форма);

	Результат = Новый Структура;
	Результат.Вставить("След", ОписаниеПозицииСлед(Форма, ИндексТекВопроса));
	Результат.Вставить("Пред", ОписаниеПозицииПред(Форма, ИндексТекВопроса));
	Возврат Результат;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеПозицииСлед(Форма, ИндексТекВопроса = Неопределено)
	Если ИндексТекВопроса = Неопределено Тогда
		ИндексТекВопроса = ИндексТекВопроса(Форма);
	КонецЕсли;

	Результат = Неопределено;
	Если Форма.УмнаяПеремоткаВключена Тогда
		ВГраница = ВГраницаВопросов(Форма);
		Для ИндексСлед = ИндексТекВопроса + 1 По ВГраница Цикл
			СтрокаТаблицы = Форма.ТаблицаВопросов[ИндексСлед];
			Если СтрокаТаблицы.Проверен Тогда
				Продолжить;
			КонецЕсли;
			Результат = НовоеОписаниеПозицииВопроса();
			Результат.Индекс = ИндексСлед;
			Результат.Вид = ВидыПозиций().След;
			Прервать;
		КонецЦикла;
	КонецЕсли;

	Если Результат = Неопределено Тогда
		Результат = ОписаниеПозицииБезУчетаРежимаПеремотки(Форма, ИндексТекВопроса, 1);
	КонецЕсли;

	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеПозицииПред(Форма, ИндексТекВопроса = Неопределено)
	Если ИндексТекВопроса = Неопределено Тогда
		ИндексТекВопроса = ИндексТекВопроса(Форма);
	КонецЕсли;

	Результат = Неопределено;
	Если Форма.УмнаяПеремоткаВключена Тогда
		ИндексПредВопроса = ИндексТекВопроса - 1;
		Для ОбратныйИндекс = -ИндексПредВопроса По 0 Цикл
			ИндексПред = -ОбратныйИндекс;
			СтрокаТаблицы = Форма.ТаблицаВопросов[ИндексПред];
			Если СтрокаТаблицы.Проверен Тогда
				Продолжить;
			КонецЕсли;
			Результат = НовоеОписаниеПозицииВопроса();
			Результат.Индекс = ИндексПред;
			Результат.Вид = ВидыПозиций().Пред;
			Прервать;
		КонецЦикла;
	КонецЕсли;

	Если Результат = Неопределено Тогда
		Результат = ОписаниеПозицииБезУчетаРежимаПеремотки(Форма, ИндексТекВопроса, -1);
	КонецЕсли;

	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВГраницаВопросов(Форма)
	Возврат Форма.ТаблицаВопросов.Количество() - 1;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция НовоеОписаниеПозицииВопроса()
	Результат = Новый Структура;
	Результат.Вставить("Вид");
	Результат.Вставить("Индекс");
	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВидыПозиций()
	Результат = Новый Структура;
	Результат.Вставить("След", "След");
	Результат.Вставить("Пред", "Пред");
	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеПозицииБезУчетаРежимаПеремотки(Форма, ИндексТекВопроса, Направление)
	ВидыПозиций = ВидыПозиций();

	ИндексПоНаправлению = ИндексТекВопроса + Направление;

	вГраница = ВГраницаВопросов(Форма);
	Результат = НовоеОписаниеПозицииВопроса();

	Если Направление = 1 Тогда
		Результат.Индекс = ?(ИндексПоНаправлению > вГраница, 0, ИндексПоНаправлению);
		Результат.Вид = ВидыПозиций.След;

	ИначеЕсли Направление = -1 Тогда
		Результат.Индекс = ?(ИндексПоНаправлению < 0, вГраница, ИндексПоНаправлению);
		Результат.Вид = ВидыПозиций.Пред;

	Иначе
		ВызватьИсключение "Ошибка при передаче направления: " + Направление;
	КонецЕсли;

	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ИндексТекВопроса(Форма)

	ИндексТекВопроса = -1;
	Если ЗначениеЗаполнено(Форма.ТекущийВопрос) Тогда
		Поиск = Новый Структура("Вопрос", Форма.ТекущийВопрос);
		СтрокиТаблицы = Форма.ТаблицаВопросов.НайтиСтроки(Поиск);
		Если ЗначениеЗаполнено(СтрокиТаблицы) Тогда
			СтрокаТаблицы = СтрокиТаблицы[0];
			ИндексТекВопроса = Форма.ТаблицаВопросов.Индекс(СтрокаТаблицы);
		КонецЕсли;
	КонецЕсли;

	Возврат ИндексТекВопроса;

КонецФункции

#КонецОбласти

#КонецОбласти
