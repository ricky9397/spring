package com.ricky.op.member.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ricky.op.member.dao.JdbctemplateMemberDao;

@Service
public class IdCheckService {

//	@Autowired
//	MemberDao dao;

	@Autowired
	private JdbctemplateMemberDao dao;

	public String idCheck(String id) {

		String result = "Y";
		//Connection conn = null;

		try {
			// conn = ConnectionProvider.getConnection();
			if (dao.selectById(id) > 0) {
				result = "N";
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
}
