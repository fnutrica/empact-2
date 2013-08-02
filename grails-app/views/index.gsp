<%@ page import="empact.Project" %>


<!DOCTYPE html>
<html>
<head>
    <g:set var="projectInstanceList" value="${empact.Project.list()}" />
    <meta name="layout" content="main"/>
    <title>Welcome to EMPaCT</title>
</head>

<body>
<!-- BEGIN BODY CONTAINER -->

<div class='main'>
    <div id='map' class='inline'></div>

<div class='container'>

<ul class="hide project-list">
    <g:each in="${projectInstanceList}" status="i" var="proj">
        <li class="project-data">
            <div class="country-name">${proj.country}</div>
            <div class="country-desc">${proj.description}</div>
        </li>
    </g:each>
</ul>
    <br>

<div class="row-fluid">
    <div class="span7">
        <div class="hero-unit">
            <center><h2>EMPaCT</h2></center>
            <p>Neglected Tropical Diseases (NTDs) -- such as lymphatic filariasis, trachoma, and soiltransmitted helminth diseases --
            strip the quality of life from the one billion people that currently bear the burden of these diseases worldwide. There is considerable
            evidence documenting the deleterious effects of these NTDs on maternal and child
            health, educational outcomes and economic development. Of the fifteen most prevalent
            NTDs, seven can be combatted by preventative chemotherapy (PCT), a cost-effective
            method utilizing mass-drug administration to reduce and potentially eliminate several
            of these diseases as public health threats. Yet despite the ease and cost-effectiveness of
            implementing PCT, political will to control NTDs is still lacking.
            <br>This web-based platform seeks to harness the intellect, creativity and innovation of
            university-level students around the world through fostering collaboration between
            officials from disease-endemic countries and a global network of students seeking to find
            relevant and applied topics for doctoral dissertations, masters theses, and honors theses.
            In matching human capital with evidentiary needs, these transnational partnerships
            will facilitate the compilation of robust and credible evidence to make the case for
            investments in NTD control, improve the efficiency of current NTD control efforts
            globally, and nurture a generation of young professionals who may take up the cause of
            NTDs in their careers, based on their experience with this project. This web portal serves
            as a site for data sharing, idea generation and matching of students to country officials.
            We hope this collaboration will generate evidence of the powerful impact that NTD
            control can have in reversing deleterious societal, political, economic and cultural effects
            in disease-endemic countries.</p>
        </div>
    </div>
    <div class="span3 offset2">
        <!-- Ticker -->
        <u><h4>Open Projects</h4></u><br>
        <div id='ticker' class='inline'>

            <g:each in="${projectInstanceList}" status="i" var ="newproj">

                <div class='project-snippet'>${newproj.name}</div>

            </g:each>

        </div>
    </div>
</div>

<center>
    <div class="row-fluid">
        <div class="span12">
            <h2><p>Want to get involved?</p></h2>
        </div>
        <div class="span4">
            <h4>If you want to do research...</h4>
            <p>We are always looking for researchers to help with analyzing data and finding solutions.
            Whether you're an undergraduate student interested in global health, a post-graduate hoping to help save the world, Batman,
            or anything in between - we'd be glad to have you on board.
            Take a look at our Open Projects to see if our projects align with your interests.</p>
        </div>
        <div class="span3">
            <h4>If you're with an NGO...</h4>
            <p>NGO Officials are a very important peoples to the EMPaCT machine!</p>
        </div>
        <div class="span4">
            <h4>If you work for the WHO...</h4>
            <p>WHO Officials are very important to this whole process.
            Too bad Annabelle doesn't really know what they're going to do.
            Whoops.</p>
        </div>
    </div>
</center>
    <g:javascript library="jquery"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBp9Xy0pbRVvSWYSLBmxF4us8sm3ZjjdrY&sensor=true"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // $('.dropdown-toggle').dropdown();
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 2,
                center: new google.maps.LatLng(15, 0),
                mapTypeId: google.maps.MapTypeId.HYBRID,
                streetViewControl: false,
                panControl: false,
                zoomControl: false,
                mapTypeControl: false
            });
            showProjects();

            var timer1 = setInterval(function () {
                $('.project-snippet').animate({
                    top: -195
                }, 500);
            }, 3000);

            var timer2 = setInterval(function () {
                $('.project-snippet').each(function (index) {
                    $(this).css({
                        top: 0
                    });
                });

                var elem = $('.project-snippet').first();

                $('#ticker').append(elem);
                elem.next().addClass('top');
            }, 4000);

            function showProjects() {
                $.ajax({
                    url: "${g.createLink(controller:'project', action:'mapMarkers')}",
                    type: 'post',
                    async: false,
                    dataType: 'json',
                    success: function (data) {
                        if (data.ok) {
                            var marker;
                            var infoWindow = new google.maps.InfoWindow();

                            $.each(data.markers, function (index, point) {
                                marker = new google.maps.Marker({
                                    position: new google.maps.LatLng(point.lat, point.lng),
                                    map: map
                                });

                                google.maps.event.addListener(marker, 'click', (function(marker, index) {
                                    return function() {
                                        infoWindow.setContent(point.project);
                                        infoWindow.open(map, marker);
                                    }
                                })(marker, index));
                            });
                        }
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            }

        });
    </script>
</body>
</html>
