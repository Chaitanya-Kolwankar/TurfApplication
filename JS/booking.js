$('.turf-location').click(function (event) {
    if (event.target.tagName.toLowerCase() === 'a') {
        event.stopPropagation();
    } else {
        $.ajax({
            type: "POST",
            url: "booking.aspx/get_type_price",
            data: '{turf_location:"' + event.currentTarget.id + '"}',
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
        document.getElementById('location').classList.remove('fade-in');
        document.getElementById('location').classList.add('fade-out');
        setTimeout(function () {
            document.getElementById('location').style.display = 'none';
            document.getElementById('type').style.display = 'block';
            document.getElementById('card_tital').innerText = 'Select Turf Type';
        }, 500);
        $('#ContentPlaceHolder1_hidden_location').val(event.currentTarget.id);
    }
});

$('.princing-item').click(function (event) {
    document.getElementById('type').classList.remove('fade-in');
    document.getElementById('type').classList.add('fade-out');
    setTimeout(function () {
        document.getElementById('type').style.display = 'none';
        document.getElementById('calender').style.display = 'block';
        renderMonth(currentMonth, currentYear);
        document.getElementById('card_tital').innerText = 'Select Date';
    }, 500);
    $('#ContentPlaceHolder1_hidden_type').val(event.currentTarget.id);
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
                ${generateDaysHTML(daysInMonth, month)}
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

function generateDaysHTML(daysInMonth, month) {
    var data;
    $.ajax({
        type: "POST",
        url: "booking.aspx/gte_blocked_days",
        data: '{month:"' + month + '"}',
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
    let currentDay = 1;
    var cssclass = 'btn-outline-primary';
    while (currentDay <= daysInMonth) {
        html += '<tr>';
        for (let i = 0; i < 7; i++) {
            var isPresent = data.some(function (item) {
                return item.Turf_date === currentDay.toString();
            });
            var cssclass = 'btn-outline-primary';
            if (((currentDay < currentDate.getDate()) && month == currentDate.getMonth()) || isPresent) {
                cssclass = 'btn-soft-gray';
            }
            if (currentDay <= daysInMonth) {
                html += '<td><label class="btn ' + cssclass + ' form-control shadow btnday" onclick="handleDayClick(this)" text="' + currentDay + '">' + currentDay + '</label></td>';
                currentDay++;
            } else {
                html += '<td></td>';
            }
        }
        html += '</tr>';
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
    var date = label.innerText + '/' + $('#prevMonthBtn').parent().next().find('h2').text().replace(' ', '/');
    document.getElementById('calender').classList.remove('fade-in');
    document.getElementById('calender').classList.add('fade-out');
    setTimeout(function () {
        document.getElementById('calender').style.display = 'none';
        document.getElementById('time').style.display = 'block';
        document.getElementById('card_tital').innerText = 'Select Turf Time';
    }, 500);
    $('#ContentPlaceHolder1_hidden_date').val(date);
}

//-------------------------Claender JS End ------------------------------------

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
    let html1 = '';
    var endHour = parseInt(24) - parseInt(durationHours);
    if (durationMinutes == '30') {

        endHour = parseInt(endHour) - parseInt(1);
    }
    for (let i = 0; i < 24; i++) {
        var clk = (i < 10) ? '0' + i : i;
        var displaymin = '';
        var displayhour = '';
        if (i > endHour) {
            displayhour = 'style="display: none;"';
            displaymin = 'style="display: none;"'
        }
        if (i == endHour && durationMinutes == '00') {
            displaymin = 'style="display: none;"'
        }
        html1 += '<tr ' + displayhour + '><td><label class="btn btn-outline-primary form-control shadow btnday" onclick="handletimeClick(this)">' + clk + ':00</label></td></tr>';
        html1 += '<tr ' + displaymin + '><td><label class="btn btn-outline-primary form-control shadow btnday" onclick="handletimeClick(this)">' + clk + ':30</label></td></tr>';
    }
    return html1;
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
    if ($('#ContentPlaceHolder1_hidden_type').val() == "full") {
        price = $('#ContentPlaceHolder1_hidden_full').val()
    } else if ($('#ContentPlaceHolder1_hidden_type').val() == "open") {
        price = $('#ContentPlaceHolder1_hidden_open').val()
    } else {
        price = $('#ContentPlaceHolder1_hidden_box').val()
    }
    var min = (selectedMin == 30) ? '0.5' : selectedMin;
    var tprice = ((parseInt(selectedhour) * parseInt(price)) + parseInt(parseFloat(min) * parseInt(price)))

    document.getElementById('time').classList.remove('fade-in');
    document.getElementById('time').classList.add('fade-out');
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
    }, 500);
}
//-------------------------TimeTable JS end------------------------------------



