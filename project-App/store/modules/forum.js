import { getAllPosts, createPost, getPostById, deletePostById } from '@/api/forum';

const state = {
  posts: []
};

const mutations = {
  SET_POSTS(state, posts) {
    state.posts = posts;
  }
};

const actions = {
  fetchPosts({ commit }) {
    getAllPosts().then(response => {
      commit('SET_POSTS', response.data);
    }).catch(error => console.error('Failed to fetch posts:', error));
  },
  createPost({ dispatch }, postData) {
    createPost(postData).then(() => {
      dispatch('fetchPosts');
    }).catch(error => console.error('Failed to create post:', error));
  },
  deletePost({ dispatch }, { id, userName }) {
    deletePostById(id, userName).then(() => {
      dispatch('fetchPosts');
    }).catch(error => console.error('Failed to delete post:', error));
  }

};

export default {
  namespaced: true,
  state,
  mutations,
  actions
};
