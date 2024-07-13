$('.turf-location').click(function (event) {
    if (event.target.tagName.toLowerCase() === 'a') {
        event.stopPropagation();
    } else {
        document.getElementById('location').classList.remove('fade-in');
        document.getElementById('location').classList.add('fade-out');
        document.getElementById('calender').classList.remove('fade-out');
        setTimeout(function () {
            document.getElementById('location').style.display = 'none';
            document.getElementById('calender').style.display = 'block';
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'calender');
            renderMonth(currentMonth, currentYear);
            document.getElementById('card_tital').innerText = 'Select Date';
        }, 500);
        $('#ContentPlaceHolder1_hidden_location').val(event.currentTarget.id);
    }
});

//-------------------------Claender JS------------------------------------
const currentDate = new Date();

let currentMonth = currentDate.getMonth();
let currentYear = currentDate.getFullYear();

document.getElementById('calendarRow').addEventListener('click', function (event) {
    if (event.target.matches('label.btn') || event.target.matches('i.fa')) {
        if (event.target.matches('.prevMonthBtn')) {
            if ((currentMonth == currentDate.getMonth()) && currentYear == currentDate.getFullYear()) {
                return;
            }
            currentMonth--;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            }
            renderMonth(currentMonth, currentYear);
        } else if (event.target.matches('.nextMonthBtn')) {
            if (currentMonth > (currentDate.getMonth() + 1)) {
                return;
            }
            currentMonth++;
            if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            renderMonth(currentMonth, currentYear);
        }
    }
});

function renderMonth(month, year) {
    document.getElementById('calendarRow').innerHTML = '';

    const daysInMonth = new Date(year, month + 1, 0).getDate();

    const monthContainer = document.createElement('div');
    monthContainer.classList.add('col-12');
    monthContainer.innerHTML = `
      <div class="card shadow">
        <div class="text-center border-bottom border-1 p-3">
            <div class="row">
                <div class="col-2"><label id="prevMonthBtn"><span><i class="fa fa-2x fa-chevron-circle-left text-primary prevMonthBtn"></i></span></label></div>
                <div class="col-8">
                    <h2 class="">${getMonthName(month)} ${year}</h2>
                </div>
                <div class="col-2"><label id="nextMonthBtn"><span><i class="fa fa-2x fa-chevron-circle-right text-primary nextMonthBtn"></i></span></label></div>
                    </div>
                </div>
        <div class="card-body">
            <div class="row">
                ${generateDaysHTML(daysInMonth, month, year)}
            </div>
        </div>
      </div>
    `;
    document.getElementById('calendarRow').appendChild(monthContainer);
}

function getMonthName(monthIndex) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[monthIndex % 12];
}

function generateDaysHTML(daysInMonth, month, year) {
    var data;
    $.ajax({
        type: "POST",
        url: "booking.aspx/gte_blocked_days",
        data: '{month:"' + month + '",turf_location:"' + $('#ContentPlaceHolder1_hidden_location').val() + '"}',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (response) {
            if (response.d != 'error') {
                data = JSON.parse(response.d);
            } else {
                $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
            }
        },
        error: function (error) {
            $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
        }
    });

    let html = '<div class="table-responsive"><table class="table table-bordered">';
    html += '<thead><tr>';
    for (let i = 0; i < 7; i++) {
        html += '<th scope="col">' + getDayName(i) + '</th>';
    }
    html += '</tr></thead>';
    html += '<tbody>';

    let firstDayOfMonth = new Date(year, month, 1).getDay();
    let dayCount = 1;

    for (let i = 0; i < 6; i++) {  // Up to 6 weeks
        html += '<tr>';
        for (let j = 0; j < 7; j++) {
            if (i === 0 && j < firstDayOfMonth) {
                html += '<td></td>';
            } else if (dayCount > daysInMonth) {
                html += '<td></td>';
            } else {
                var isPresent = data.some(function (item) {
                    return item.Turf_date === dayCount.toString();
                });
                var cssclass = 'btn-outline-primary';
                if (((dayCount < currentDate.getDate()) && month == currentDate.getMonth() && year == currentDate.getFullYear()) || isPresent) {
                    cssclass = 'btn-soft-gray';
                }
                html += '<td><label class="btn ' + cssclass + ' form-control shadow btnday" onclick="handleDayClick(this)" text="' + dayCount + '">' + dayCount + '</label></td>';
                dayCount++;
            }
        }
        html += '</tr>';
        if (dayCount > daysInMonth) break;
    }
    html += '</tbody></table></div>';
    return html;
}

function getDayName(dayIndex) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[dayIndex % 7];
}

function handleDayClick(label) {
    if (label.classList.contains('btn-soft-gray')) {
        return;
    }
    else {
        var date = label.innerText + '/' + $('#prevMonthBtn').parent().next().find('h2').text().replace(' ', '/');
        $.ajax({
            type: "POST",
            url: "booking.aspx/get_type_price",
            data: '{turf_location:"' + $('#ContentPlaceHolder1_hidden_location').val() + '",date:"' + date + '"}',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (response) {
                if (response.d != 'error') {
                    var data = JSON.parse(response.d);
                    if (data.length > 0) {
                        var row = data[0];
                        $('.lbl_full_court').text(row.Full_price);
                        $('.lbl_open_court').text(row.Open_price);
                        $('.lbl_box_court').text(row.Box_price);
                        $('#ContentPlaceHolder1_hidden_full').val(row.Full_price);
                        $('#ContentPlaceHolder1_hidden_open').val(row.Open_price);
                        $('#ContentPlaceHolder1_hidden_box').val(row.Box_price);
                        $('#ContentPlaceHolder1_hidden_percent').val(row.Adv_price);
                    }
                } else {
                    $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
                }
            },
            error: function (error) {
                $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
            }
        });
        var date = label.innerText + '/' + $('#prevMonthBtn').parent().next().find('h2').text().replace(' ', '/');
        document.getElementById('calender').classList.remove('fade-in');
        document.getElementById('calender').classList.add('fade-out');
        document.getElementById('type').classList.remove('fade-out');
        setTimeout(function () {
            document.getElementById('calender').style.display = 'none';
            document.getElementById('type').style.display = 'block';
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'type');
            document.getElementById('card_tital').innerText = 'Select Turf Type';
        }, 500);
        $('#ContentPlaceHolder1_hidden_date').val(date);
    }
}
//-------------------------Claender JS End ------------------------------------

$('.princing-item').click(function (event) {

    document.getElementById('type').classList.remove('fade-in');
    document.getElementById('type').classList.add('fade-out');
    document.getElementById('time').classList.remove('fade-out');
    setTimeout(function () {
        document.getElementById('type').style.display = 'none';
        document.getElementById('time').style.display = 'block'
        document.querySelector('.btn_previous').setAttribute('data-toggle', 'time');;
        document.getElementById('card_tital').innerText = 'Select Time';
    }, 500);
    $('#ContentPlaceHolder1_hidden_type').val(event.currentTarget.id);
});

//-------------------------TimeTable JS ---------------------------------------
var selectedhour = '';
$('.ddl_hour').change(function () {
    selectedhour = $(this).val();
    $('.ddl_min').css("display", "none");
    $('.txt_timetotal').css("display", "none");
    $('.txt_timetotal').val('');
    document.getElementById('timetable').innerHTML = '';
    document.getElementById('start_time').style.display = 'none';
    $('.ddl_min').prop('selectedIndex', 0);
    if (!selectedhour == '') {
        setTimeout(function () {
            $('.ddl_min').addClass('fade-in')
            $('.ddl_min').css("display", "block");
            if (selectedhour == '24') {
                $('.ddl_min').prop('selectedIndex', 1);
                $('.ddl_min').trigger('change');
            }
        }, 200);
    }
})
var selectedMin = '';
$('.ddl_min').change(function () {
    selectedMin = $(this).val();
    $('.txt_timetotal').css("display", "none");
    $('.txt_timetotal').val('');
    document.getElementById('timetable').innerHTML = '';
    document.getElementById('start_time').style.display = 'none';
    if (!selectedMin == '') {
        setTimeout(function () {
            $('.txt_timetotal').addClass('fade-in')
            $('.txt_timetotal').css("display", "block");
            document.getElementById('start_time').style.display = 'block';
            $('.txt_timetotal').val(selectedhour + ' Hours ' + selectedMin + ' Mins');
            gettimetable();
        }, 200);
    }
})

function gettimetable() {
    document.getElementById('timetable').innerHTML = '';
    const timeContainer = document.createElement('div');
    timeContainer.classList.add('table-responsive');
    timeContainer.innerHTML = `
        <table class="table table-bordered fade-in" id="tbl_time" >
            <tbody>
                ${genatretime(selectedhour, selectedMin)}
            </tbody>
        </table>`;
    document.getElementById('timetable').appendChild(timeContainer);
}

function genatretime(durationHours, durationMinutes) {
    let blockedTimes = [];

    // Fetch blocked times from the server
    $.ajax({
        type: "POST",
        url: "booking.aspx/gte_blocked_time",
        data: '{date:"' + $('#ContentPlaceHolder1_hidden_date').val() + '",turf_location:"' + $('#ContentPlaceHolder1_hidden_location').val() + '"}',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (response) {
            if (response.d != 'error') {
                blockedTimes = JSON.parse(response.d);
            } else {
                $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
            }
        },
        error: function (error) {
            $.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
        }
    });

    let html1 = '';
    const durationInMinutes = parseInt(durationHours) * 60 + parseInt(durationMinutes);
    const lastStartTime = 24 * 60 - durationInMinutes;

    for (let i = 0; i < 24; i++) {
        for (let m = 0; m < 60; m += 30) {
            const currentTime = i * 60 + m;
            const potentialEndTime = currentTime + durationInMinutes;

            let isBlocked = isTimeBlocked(currentTime, potentialEndTime, blockedTimes);
            let isImpossible = currentTime > lastStartTime;

            const displayStyle = isBlocked || isImpossible ? 'style="display: none;"' : '';
            const timeString = `${String(i).padStart(2, '0')}:${String(m).padStart(2, '0')}`;

            html1 += `<tr ${displayStyle}><td><label class="btn btn-outline-primary form-control shadow btnday" onclick="handletimeClick(this)">${timeString}</label></td></tr>`;
        }
    }
    return html1;
}

function parseTime(timeString) {
    const [hours, minutes] = timeString.split(':').map(Number);
    return hours * 60 + minutes;
}

function isTimeBlocked(start, end, blockedTimes) {
    return blockedTimes.some(range => {
        const rangeStart = parseTime(range.Form_time);
        const rangeEnd = parseTime(range.To_time);
        return (start < rangeEnd && end > rangeStart) ||
            (start >= rangeStart && start < rangeEnd) ||
            (end > rangeStart && end <= rangeEnd);
    });
}

function handletimeClick(label) {
    $('#ContentPlaceHolder1_hidden_from_time').val(label.innerText);
    selectedhour = (selectedhour < 10) ? '0' + selectedhour : selectedhour;
    $('#ContentPlaceHolder1_hidden_total_time').val(selectedhour + ':' + selectedMin);
    var parts = label.innerText.split(':');
    var hours = (parseInt(parts[0]) + parseInt(selectedhour));
    var minutes = (parseInt(parts[1]) + parseInt(selectedMin))
    if (minutes == 60) {
        hours++;
        minutes = 0;
    }
    hours = (hours < 10) ? '0' + hours : hours;
    minutes = (minutes < 10) ? '0' + minutes : minutes;
    $('#ContentPlaceHolder1_hidden_to_time').val(hours + ':' + minutes);

    var price = "";
    if ($('#ContentPlaceHolder1_hidden_type').val() == "Full") {
        price = $('#ContentPlaceHolder1_hidden_full').val()
    } else if ($('#ContentPlaceHolder1_hidden_type').val() == "Open") {
        price = $('#ContentPlaceHolder1_hidden_open').val()
    } else {
        price = $('#ContentPlaceHolder1_hidden_box').val()
    }
    var min = (selectedMin == 30) ? '0.5' : selectedMin;
    var tprice = ((parseInt(selectedhour) * parseInt(price)) + parseInt(parseFloat(min) * parseInt(price)))

    document.getElementById('time').classList.remove('fade-in');
    document.getElementById('time').classList.add('fade-out');
    document.getElementById('user').classList.remove('fade-out');
    setTimeout(function () {
        $('.txt_location').val($('#ContentPlaceHolder1_hidden_location').val());
        $('.txt_date').val($('#ContentPlaceHolder1_hidden_date').val());
        $('.txt_from_time').val($('#ContentPlaceHolder1_hidden_from_time').val());
        $('.txt_to_time').val($('#ContentPlaceHolder1_hidden_to_time').val());
        $('.lbl_turf_type').val(($('.lbl_turf_type').val()) + $('#ContentPlaceHolder1_hidden_type').val());
        $('.lbl_price').val(($('.lbl_price').val()) + price);
        $('.lbl_time').val(($('.lbl_time').val()) + ($('.txt_timetotal').val()));
        $('.lbl_totalPrice').val(($('.lbl_totalPrice').val()) + tprice);
        $('#ContentPlaceHolder1_hidden_price').val(tprice);
        document.getElementById('time').style.display = 'none';
        document.getElementById('user').style.display = 'block';
        document.getElementById('card_tital').innerText = 'Fill Details';
        document.querySelector('.btn_previous').setAttribute('data-toggle', 'user');
    }, 500);
}
//-------------------------TimeTable JS end------------------------------------
$('.btn_previous').click(function () {
    var dataToggle = $(this).attr('data-toggle');
    if (dataToggle === 'location') {
        return;
        
    } else if (dataToggle === 'calender'){
        document.getElementById('calender').classList.remove('fade-in');
        document.getElementById('calender').classList.add('fade-out');
        document.getElementById('location').classList.remove('fade-out');
        setTimeout(function () {
            document.getElementById('calender').style.display = 'none';
            document.getElementById('location').style.display = 'block';
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'location');
            document.getElementById('card_tital').innerText = 'Select Location';
        }, 500);
        $('#ContentPlaceHolder1_hidden_location').val("");
    }
    else if (dataToggle === 'type') {
        document.getElementById('type').classList.remove('fade-in');
        document.getElementById('type').classList.add('fade-out');
        document.getElementById('calender').classList.remove('fade-out');
        setTimeout(function () {
            document.getElementById('type').style.display = 'none';
            document.getElementById('calender').style.display = 'block'
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'calender');
            renderMonth(currentMonth, currentYear);
            document.getElementById('card_tital').innerText = 'Select Calender';
        }, 500);
        $('#ContentPlaceHolder1_hidden_date').val("");
    }
    else if (dataToggle === 'time') {
        document.getElementById('time').classList.remove('fade-in');
        document.getElementById('time').classList.add('fade-out');
        document.getElementById('type').classList.remove('fade-out');
        setTimeout(function () {
            document.getElementById('time').style.display = 'none';
            document.getElementById('type').style.display = 'block'
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'type');
            document.getElementById('card_tital').innerText = 'Select Calender';
        }, 500);
        $('#ContentPlaceHolder1_hidden_type').val("");

    }
    else if (dataToggle === 'user') {
        document.getElementById('user').classList.remove('fade-in');
        document.getElementById('user').classList.add('fade-out');
        document.getElementById('time').classList.remove('fade-out');
        setTimeout(function () {
            $('.txt_location').val("");
            $('.txt_date').val("");
            $('.txt_from_time').val("");
            $('.txt_to_time').val("");
            $('.lbl_turf_type').val("");
            $('.lbl_price').val("");
            $('.lbl_time').val("");
            $('.lbl_totalPrice').val("");
            $('#ContentPlaceHolder1_hidden_price').val("");
            document.getElementById('user').style.display = 'none';
            document.getElementById('time').style.display = 'block';
            document.getElementById('card_tital').innerText = 'Fill Details';
            document.querySelector('.btn_previous').setAttribute('data-toggle', 'time');
        }, 500);
    }
});