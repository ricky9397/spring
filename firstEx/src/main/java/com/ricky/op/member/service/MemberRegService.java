package com.ricky.op.member.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ricky.op.member.dao.JdbctemplateMemberDao;
import com.ricky.op.member.domain.Member;
import com.ricky.op.member.domain.MemberRegRequest;

@Service
public class MemberRegService {
	final String UPLOAD_URI = "/uploadfile";
//	@Autowired
//	private MemberDao dao;

	@Autowired
	private JdbctemplateMemberDao dao;

	public int memberReg(MemberRegRequest regRequest, HttpServletRequest request) {
		int resultCnt = 0;
		// Connection conn = null;
		File newFile = null;
		try {
			// 1. 파일 저장
			// 시스템 경로
			String path = request.getSession().getServletContext().getRealPath(UPLOAD_URI);
			// 새로운 저장 폴더 : File
			File newDir = new File(path);

			// 폴더가 존재하지 않으면 폴더 생성
			if (!newDir.exists()) {
				newDir.mkdir();
				System.out.println("저장 폴더를 생성했습니다.");
			}

			// 파일 저장시에 파일 이름이 같으면 덮어쓴다 -> 회원별 고유한 파일 이름을 만들자!!
			String newFileName = regRequest.getMemberid() + System.currentTimeMillis();
			// 새로운 File 객체
			newFile = new File(newDir, newFileName);

			// Member 객체 생성 -> 저장된 파일의 이름을 set
			Member member = regRequest.toMember();

			// 파일 저장
			if (regRequest.getPhoto() != null && !regRequest.getPhoto().isEmpty()) {
				regRequest.getPhoto().transferTo(newFile);
				member.setMemberphoto(newFileName);
			}

			// 2. dao 저장s
			// conn = ConnectionProvider.getConnection();

			resultCnt = dao.insertMember1(member);
			
			System.out.println("새롭게 등록된 idx => " + member.getIdx());
			
			// idx 값은 자식 테이블의 insert 시 외래키로 사용
			
			// 자식 테이블 insert 구문 .....
			
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// DB 예외 발생 시 -> 저장된 파일을 삭제
			if (newFile != null && newFile.exists()) {
				newFile.delete();
			}
			e.printStackTrace();
		}

		return resultCnt;

	}

}
