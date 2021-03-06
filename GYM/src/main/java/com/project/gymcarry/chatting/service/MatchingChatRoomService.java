package com.project.gymcarry.chatting.service;

import java.util.List;
import java.util.Map;

import com.project.gymcarry.carrylike.CarryLikeDto;
import com.project.gymcarry.chatting.ChatListDto;
import com.project.gymcarry.chatting.ChatRoomDto;

public interface MatchingChatRoomService {

	/**
	 * 채팅방 IDX, 채팅방 나간 여부 확인값을 불러와 맵에 저장
	 * @param inOutMap
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectByChatRoom(Map<String, Object> inOutMap) throws Exception;
	
	/**
	 * 채팅방 나갔다 다시 들어 왔을때 나감여부 update
	 * @param roomNum
	 * @return
	 * @throws Exception
	 */
	int updateInCount(Map<String, Object> roomNum) throws Exception;
	
	/**
	 * 채팅방 처음 생성 insert
	 * @param inOutMap
	 * @return
	 * @throws Exception
	 */
	int insertChatRoom(Map<String, Object> inOutMap) throws Exception;
	
	
	
	int getByChatIdx(int chatidx);

	int getInChatRoom(int chatidx);

	int getAddChatRoom(int cridx, int memidx);

	List<ChatListDto> getChatList(int memidx);

	List<ChatListDto> getChatLists(int cridx);

	List<ChatRoomDto> getChatIdx(int chatidx);

	int getChatRead(int chatidx);

	CarryLikeDto getCheckLike(int memidx, int cridx);

	int getChatLike(int memidx, int cridx, int likecheck);

	int updateChatLike(int likecheck, int memidx, int cridx);

	int getOutChatRoom(int chatidx);

	int getOutCarryChatRoom(int chatidx);

	int deleteChatRoom(int chatidx);

	List<ChatRoomDto> getMemberMessage(int chatidx);

	







	

	

	


	

	

}
