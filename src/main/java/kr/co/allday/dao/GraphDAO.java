package kr.co.allday.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.GraphBean;
import kr.co.allday.mapper.GraphMapper;

@Repository
public class GraphDAO {

	@Autowired
	private GraphMapper graphMapper;
	
	public List<GraphBean> getMonthData(String checkStore){
		return graphMapper.getMonthData(checkStore);
	}
}
