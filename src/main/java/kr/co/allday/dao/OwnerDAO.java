package kr.co.allday.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.mapper.OwnerMapper;
@Repository
public class OwnerDAO {
	
	@Autowired
	private OwnerMapper ownerMapper;
	
	public List<ProductBean> SearchProduct(String ProductName) {
		return ownerMapper.SearchProduct(ProductName);
	}

}
