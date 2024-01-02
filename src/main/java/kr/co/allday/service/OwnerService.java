package kr.co.allday.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.dao.OwnerDAO;
@Service
public class OwnerService {
	
	@Autowired
	private OwnerDAO ownerDAO;
	
	public List<ProductBean> SearchProduct(String ProductName){
		return ownerDAO.SearchProduct(ProductName);
	}

}
