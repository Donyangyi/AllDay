<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AllDay</title>

	<!-- Stylesheets -->
    <link href="${root}css/styles.css" rel="stylesheet" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
    	body{
    		margin-top: 120px;
    	}
    
        .charts-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: row;
            margin-top: 50px;
            
        }

        .chart-box {
            flex: 1;
            margin: 20px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            padding: 20px;
            border-radius: 15px;
            background-color: #f8f9fa;
            text-align: center;
        }

        .chart-header {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        canvas {
            width: 100% !important;
            height: auto ;
        }
        
        piechart{
        	height: 400px;
        }
        
    </style>
    
    
</head>

	<script>
	        
	        $(document).ready(function() {
	        	var storeName = "${requestScope.loginUserBean.storeName}";
	            var myBarChart; // 막대 그래프
	            var myPieChart; // 파이 그래프

	            // AJAX 요청 및 차트 생성
	            $.ajax({
	                url: '${root}chartData/' + storeName,
	                type: 'GET',
	                dataType: 'json',
	                success: function(data) {
	                    var labels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
	                    var datasets = [];

	                    data.forEach(function(stackGraphBean) {
	                        datasets.push({
	                            label: stackGraphBean.label,
	                            data: stackGraphBean.values,
	                            backgroundColor: randomColor()
	                        });
	                    });

	                    var chartData = {
	                        labels: labels,
	                        datasets: datasets
	                    };

	                    myBarChart = createChart('bar', 'myChart', chartData);
	                }
	            });
	            
	            $('#myChart').click(function(e) {
	                var activePoints = myBarChart.getElementsAtEventForMode(e, 'nearest', { intersect: true }, true);
	                if (activePoints.length) {
	                    var dataIndex = activePoints[0].index; // 클릭된 막대의 월 인덱스

	                    // 클릭된 월의 상위 4개 제품 데이터를 추출 (사실 4개만 가져오기 때문에 필요 없지만 혹시해서 처리함)
	                    var topProductsData = myBarChart.data.datasets.map(function(dataset) {
	                        return {
	                            label: dataset.label,
	                            value: dataset.data[dataIndex],
	                            backgroundColor: dataset.backgroundColor
	                        };
	                    }).sort(function(a, b) {
	                        return b.value - a.value; // 내림차순 정렬
	                    }).slice(0, 4); // 상위 4개만 선택

	                    // 파이 차트 데이터 생성
	                    var pieChartData = {
	                        labels: topProductsData.map(function(item) { return item.label; }),
	                        datasets: [{
	                            data: topProductsData.map(function(item) { return item.value; }),
	                            backgroundColor: topProductsData.map(function(item) { return item.backgroundColor; }),
	                            borderColor: topProductsData.map(function(item) { return item.backgroundColor; }),
	                            borderWidth: 1
	                        }]
	                    };

	                    if (myPieChart) {
	                        myPieChart.destroy(); // 기존 파이 차트 제거
	                    }

	                    myPieChart = createChart('pie', 'pieChart', pieChartData); // 새 파이 차트 생성
	                }
	            });

	            function randomColor() {
	                var r = Math.floor(Math.random() * 256);
	                var g = Math.floor(Math.random() * 256);
	                var b = Math.floor(Math.random() * 256);
	                return 'rgba(' + r + ', ' + g + ', ' + b + ', 0.5)';
	            }

	            function createChart(type, canvasId, chartData) {
	                var ctx = document.getElementById(canvasId).getContext('2d');
	                var chartOptions = {
	                    scales: {
	                        y: {
	                            stacked: true
	                        },
	                        x: {
	                            stacked: true
	                        }
	                    },
	                    plugins: {
	                        legend: {
	                            display: type === 'pie' // 파이 차트일 경우에만 라벨을 표시합니다.
	                        }
	                    }
	                };

	                return new Chart(ctx, {
	                    type: type,
	                    data: chartData,
	                    options: chartOptions
	                });
	            }
	        });

    </script>
    
<body>

	<c:import url="/WEB-INF/views/include/top_owner.jsp" />

    <div class="charts-container">
        <div class="chart-box">
		    <div class="chart-header">월별 판매량 Top 4</div>
		    <canvas id="myChart"></canvas>
		</div>

        <div class="chart-box">
		    <div class="chart-header">제품별 상세 분석</div>
		    <canvas id="pieChart" class="piechart" style="max-height: 350px;"></canvas>
		</div>
    </div>


</body>
</html>