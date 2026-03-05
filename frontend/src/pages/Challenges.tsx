import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { getChallenges, getCategories, getProgress } from '../api/client'
import { Star, CheckCircle, Circle, PlayCircle } from 'lucide-react'

interface Challenge {
  id: number
  title: string
  description: string
  dataset: string
  difficulty: number
  category_name: string
  category_slug: string
}

interface Category {
  id: number
  name: string
  slug: string
  difficulty: string
  challenge_count: number
}

interface ProgressItem {
  challenge_id: number
  status: string
}

export default function Challenges() {
  const [challenges, setChallenges] = useState<Challenge[]>([])
  const [categories, setCategories] = useState<Category[]>([])
  const [progress, setProgress] = useState<Map<number, string>>(new Map())
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const loadData = async () => {
      setLoading(true)
      try {
        const [challengesData, categoriesData, progressData] = await Promise.all([
          getChallenges(selectedCategory ? { category: selectedCategory } : undefined),
          getCategories(),
          getProgress(),
        ])
        setChallenges(challengesData)
        setCategories(categoriesData)

        const progressMap = new Map<number, string>()
        progressData.forEach((p: ProgressItem) => {
          progressMap.set(p.challenge_id, p.status)
        })
        setProgress(progressMap)
      } catch (error) {
        console.error('Failed to load challenges:', error)
      }
      setLoading(false)
    }
    loadData()
  }, [selectedCategory])

  const getStatusIcon = (challengeId: number) => {
    const status = progress.get(challengeId)
    switch (status) {
      case 'solved':
        return <CheckCircle size={18} className="text-green-500" />
      case 'attempted':
        return <PlayCircle size={18} className="text-yellow-500" />
      default:
        return <Circle size={18} className="text-gray-600" />
    }
  }

  const getDifficultyBadge = (difficulty: string) => {
    const colors: Record<string, string> = {
      beginner: 'bg-green-900/50 text-green-400',
      intermediate: 'bg-yellow-900/50 text-yellow-400',
      advanced: 'bg-red-900/50 text-red-400',
    }
    return colors[difficulty] || colors.beginner
  }

  // Group challenges by category
  const groupedChallenges = challenges.reduce((acc, challenge) => {
    if (!acc[challenge.category_name]) {
      acc[challenge.category_name] = []
    }
    acc[challenge.category_name].push(challenge)
    return acc
  }, {} as Record<string, Challenge[]>)

  return (
    <div className="p-6 max-w-6xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">SQL Challenges</h1>

      {/* Category filters */}
      <div className="flex flex-wrap gap-2 mb-6">
        <button
          onClick={() => setSelectedCategory(null)}
          className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
            selectedCategory === null
              ? 'bg-sql-accent text-white'
              : 'bg-gray-800 text-gray-400 hover:text-white'
          }`}
        >
          All
        </button>
        {categories.map((cat) => (
          <button
            key={cat.slug}
            onClick={() => setSelectedCategory(cat.slug)}
            className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
              selectedCategory === cat.slug
                ? 'bg-sql-accent text-white'
                : 'bg-gray-800 text-gray-400 hover:text-white'
            }`}
          >
            {cat.name}
            <span className={`ml-2 px-1.5 py-0.5 rounded text-xs ${getDifficultyBadge(cat.difficulty)}`}>
              {cat.challenge_count}
            </span>
          </button>
        ))}
      </div>

      {loading ? (
        <div className="text-center text-gray-500 py-12">Loading challenges...</div>
      ) : (
        <div className="space-y-8">
          {Object.entries(groupedChallenges).map(([category, categoryChalllenges]) => (
            <div key={category}>
              <h2 className="text-lg font-semibold mb-4 text-gray-300">{category}</h2>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                {categoryChalllenges.map((challenge) => (
                  <Link
                    key={challenge.id}
                    to={`/challenges/${challenge.id}`}
                    className="block p-4 bg-sql-dark border border-gray-700 rounded-lg hover:border-sql-accent transition-colors"
                  >
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-2">
                        {getStatusIcon(challenge.id)}
                        <h3 className="font-medium">{challenge.title}</h3>
                      </div>
                    </div>
                    <p className="text-sm text-gray-500 mb-3 line-clamp-2">
                      {challenge.description}
                    </p>
                    <div className="flex items-center justify-between">
                      <span className="text-xs px-2 py-1 bg-gray-800 rounded text-gray-400">
                        {challenge.dataset}
                      </span>
                      <div className="flex items-center gap-0.5">
                        {Array.from({ length: 5 }).map((_, i) => (
                          <Star
                            key={i}
                            size={12}
                            className={
                              i < challenge.difficulty
                                ? 'text-yellow-500 fill-yellow-500'
                                : 'text-gray-700'
                            }
                          />
                        ))}
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
