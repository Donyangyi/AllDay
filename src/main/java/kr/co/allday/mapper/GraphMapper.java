package kr.co.allday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.GraphBean;

public interface GraphMapper {

	//누적 그래프에서 사용할 점포별 월별 판매 갯수가 가장 높은 상품 4위까지 출력
	@Select("WITH MonthlySales AS ( SELECT TO_CHAR(PAY.paymentdate, 'YYYY-MM') AS sale_month, "
			+ "PAY.storename, PI.productno, SUM(PI.paymentquantity) AS total_quantity "
			+ "FROM payments PAY "
			+ "JOIN paymentsinfo PI ON PAY.paymentno = PI.paymentno "
			+ "WHERE pay.storename = #{checkStore} AND PAY.paymentdate >= ADD_MONTHS(TRUNC(SYSDATE), -12)  "
			+ "GROUP BY TO_CHAR(PAY.paymentdate, 'YYYY-MM'), PAY.storename, PI.productno), "
			+ "RankedMonthlySales AS ( "
			+ "SELECT TO_CHAR(TO_DATE(sale_month, 'YYYY-MM'), 'MM') AS sale_month, storename, productno, total_quantity, "
			+ "ROW_NUMBER() OVER (PARTITION BY sale_month, storename ORDER BY total_quantity DESC) AS sales_rank "
			+ "FROM MonthlySales ) "
			+ "SELECT RMS.sale_month, RMS.storename, P.productname, RMS.total_quantity AS max_quantity_sold "
			+ "FROM RankedMonthlySales RMS "
			+ "JOIN products P ON RMS.productno = P.productno "
			+ "WHERE RMS.sales_rank <= 4 order by sale_month")
	List<GraphBean> getMonthData(String checkStore);
	
}
