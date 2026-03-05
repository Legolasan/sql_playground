import axios from 'axios'

const API_BASE = '/api'

export const api = axios.create({
  baseURL: API_BASE,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Query execution
export const executeQuery = async (query: string, dataset: string) => {
  const response = await api.post('/execute', { query, dataset })
  return response.data
}

export const explainQuery = async (query: string, dataset: string) => {
  const response = await api.post('/explain', { query, dataset })
  return response.data
}

export const validateQuery = async (query: string, challengeId: number) => {
  const response = await api.post('/validate', { query, challenge_id: challengeId })
  return response.data
}

// AI Feedback
export const getFeedback = async (
  query: string,
  dataset: string,
  challengeId?: number,
  errorMessage?: string
) => {
  const response = await api.post('/feedback', {
    query,
    dataset,
    challenge_id: challengeId,
    error_message: errorMessage,
  })
  return response.data
}

export const getHint = async (challengeId: number, level: number = 1) => {
  const response = await api.post('/hint', {
    challenge_id: challengeId,
    hint_level: level,
  })
  return response.data
}

// Challenges
export const getChallenges = async (filters?: {
  category?: string
  difficulty?: number
  dataset?: string
}) => {
  const response = await api.get('/challenges', { params: filters })
  return response.data
}

export const getChallenge = async (id: number) => {
  const response = await api.get(`/challenges/${id}`)
  return response.data
}

export const getCategories = async () => {
  const response = await api.get('/categories')
  return response.data
}

// Progress
export const getProgress = async () => {
  const response = await api.get('/progress')
  return response.data
}

export const updateProgress = async (
  challengeId: number,
  status: string,
  solution?: string
) => {
  const response = await api.post(`/progress/${challengeId}`, {
    status,
    solution,
  })
  return response.data
}

export const getStats = async () => {
  const response = await api.get('/stats')
  return response.data
}

// Saved queries
export const getSavedQueries = async () => {
  const response = await api.get('/saved')
  return response.data
}

export const saveQuery = async (
  title: string,
  query: string,
  dataset: string,
  notes?: string
) => {
  const response = await api.post('/saved', { title, query, dataset, notes })
  return response.data
}

export const deleteSavedQuery = async (id: number) => {
  const response = await api.delete(`/saved/${id}`)
  return response.data
}

export const toggleBookmark = async (id: number) => {
  const response = await api.post(`/saved/${id}/bookmark`)
  return response.data
}

// Schema
export const getSchema = async (dataset: string) => {
  const response = await api.get(`/schema/${dataset}`)
  return response.data
}

export const getTables = async (dataset: string) => {
  const response = await api.get(`/tables/${dataset}`)
  return response.data
}

export const getTableInfo = async (dataset: string, tableName: string) => {
  const response = await api.get(`/table/${dataset}/${tableName}`)
  return response.data
}
