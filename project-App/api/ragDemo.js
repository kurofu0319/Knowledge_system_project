import axios from 'axios';
import config from '@/config.js';

const mainbaseUrl = config.baseUrl;
const baseURL = 'http://172.20.10.2:8080';

export function uploadDocument(file) {
  const formData = new FormData();
  formData.append('File', file);

  return axios.post(`${baseURL}/api/vi/rag/upload`, formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  });
}

export function searchDocument(keyword) {
  return axios.get(`${baseURL}/api/vi/rag/search`, {
    params: { keyword }
  });
}

export function chatWithDocument(message) {
  return axios.get(`${baseURL}/api/vi/rag/chat`, {
    params: { message }
  });
}
