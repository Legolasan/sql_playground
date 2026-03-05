import { create } from 'zustand'

interface QueryResult {
  success: boolean
  columns: string[]
  rows: any[][]
  row_count: number
  execution_time_ms: number
  error?: string
}

interface Challenge {
  id: number
  title: string
  description: string
  hint?: string
  starter_code?: string
  dataset: string
  difficulty: number
  category_name: string
  category_slug: string
}

interface PlaygroundState {
  // Query state
  query: string
  setQuery: (query: string) => void

  // Dataset
  dataset: 'ecommerce' | 'hr' | 'finance'
  setDataset: (dataset: 'ecommerce' | 'hr' | 'finance') => void

  // Results
  results: QueryResult | null
  setResults: (results: QueryResult | null) => void

  // Loading states
  isExecuting: boolean
  setIsExecuting: (loading: boolean) => void

  // Current challenge
  currentChallenge: Challenge | null
  setCurrentChallenge: (challenge: Challenge | null) => void

  // UI state
  showExplain: boolean
  setShowExplain: (show: boolean) => void

  showFeedback: boolean
  setShowFeedback: (show: boolean) => void

  sidebarOpen: boolean
  setSidebarOpen: (open: boolean) => void

  // Feedback
  feedback: {
    feedback: string
    suggestions: string[]
    optimizations: string[]
    is_correct?: boolean
  } | null
  setFeedback: (feedback: any) => void

  // Explain results
  explainResult: {
    plan: any[]
    plan_text: string
    total_cost?: number
    execution_time_ms?: number
  } | null
  setExplainResult: (result: any) => void
}

export const usePlaygroundStore = create<PlaygroundState>((set) => ({
  // Query
  query: '-- Write your SQL query here\nSELECT * FROM customers LIMIT 10;',
  setQuery: (query) => set({ query }),

  // Dataset
  dataset: 'ecommerce',
  setDataset: (dataset) => set({ dataset }),

  // Results
  results: null,
  setResults: (results) => set({ results }),

  // Loading
  isExecuting: false,
  setIsExecuting: (isExecuting) => set({ isExecuting }),

  // Challenge
  currentChallenge: null,
  setCurrentChallenge: (currentChallenge) => set({ currentChallenge }),

  // UI
  showExplain: false,
  setShowExplain: (showExplain) => set({ showExplain }),

  showFeedback: false,
  setShowFeedback: (showFeedback) => set({ showFeedback }),

  sidebarOpen: true,
  setSidebarOpen: (sidebarOpen) => set({ sidebarOpen }),

  // Feedback
  feedback: null,
  setFeedback: (feedback) => set({ feedback }),

  // Explain
  explainResult: null,
  setExplainResult: (explainResult) => set({ explainResult }),
}))
