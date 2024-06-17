import axios from 'axios';
import request from '@/utils/request';

const OLLAMA_API_URL = 'http://localhost:11434';

// 调用 Ollama API 生成补全
export async function generateOllamaCompletion(prompt) {
  try {
    const response = await axios.post(
      `${OLLAMA_API_URL}/api/generate`,
      {
        model: 'qwen:4b',
        prompt: prompt,
        stream: false
      },
      {
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
    return response.data;
  } catch (error) {
    console.error('Error generating completion:', error);
    throw error;
  }
}

// 调用 Ollama API 进行对话补全
export async function chatOllama(messages) {
  try {
    const response = await axios.post(
      `${OLLAMA_API_URL}/api/chat`,
      {
        model: 'qwen:7b',
        messages: messages,
        stream: false
      },
      {
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
    return response.data;
  } catch (error) {
    console.error('Error in chat completion:', error);
    throw error;
  }
}

export function formatDateTime(date) {
  const yyyy = date.getFullYear();
  const mm = String(date.getMonth() + 1).padStart(2, '0'); // Months start at 0!
  const dd = String(date.getDate()).padStart(2, '0');
  const hh = String(date.getHours()).padStart(2, '0');
  const min = String(date.getMinutes()).padStart(2, '0');
  const ss = String(date.getSeconds()).padStart(2, '0');
  
  return `${yyyy}-${mm}-${dd} ${hh}:${min}:${ss}`;
}

// 保存搜索历史记录
export function saveSearchHistory(userName, searchKeyword, results) {
  const currentTime = formatDateTime(new Date());
  return request({
    url: '/system/history/add',
    method: 'post',
    data: {
      userName: userName,
      searchKeyword: searchKeyword,
      results: JSON.stringify(results),
	  searchTime: currentTime
    },
    headers: {
      'Content-Type': 'application/json'
    }
  });
}

export function getUserSearchHistory(userName) {
  return request({
    url: `/system/history/list/${userName}`,
    method: 'get',
  });
}
