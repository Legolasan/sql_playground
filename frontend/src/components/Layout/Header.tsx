import { Link, useLocation } from 'react-router-dom'
import { Database, BookOpen, BarChart3, Menu } from 'lucide-react'
import { usePlaygroundStore } from '../../store/store'

export default function Header() {
  const location = useLocation()
  const { sidebarOpen, setSidebarOpen } = usePlaygroundStore()

  const navItems = [
    { path: '/', label: 'Playground', icon: Database },
    { path: '/challenges', label: 'Challenges', icon: BookOpen },
    { path: '/progress', label: 'Progress', icon: BarChart3 },
  ]

  return (
    <header className="h-14 bg-sql-dark border-b border-gray-800 flex items-center px-4">
      <button
        onClick={() => setSidebarOpen(!sidebarOpen)}
        className="p-2 hover:bg-gray-800 rounded-lg mr-4"
      >
        <Menu size={20} />
      </button>

      <Link to="/" className="flex items-center gap-2 mr-8">
        <Database className="text-sql-accent" size={24} />
        <span className="font-semibold text-lg">SQL Playground</span>
      </Link>

      <nav className="flex gap-1">
        {navItems.map(({ path, label, icon: Icon }) => (
          <Link
            key={path}
            to={path}
            className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${
              location.pathname === path
                ? 'bg-sql-accent text-white'
                : 'text-gray-400 hover:text-white hover:bg-gray-800'
            }`}
          >
            <Icon size={18} />
            <span>{label}</span>
          </Link>
        ))}
      </nav>

      <div className="ml-auto flex items-center gap-4">
        <span className="text-sm text-gray-500">Learn SQL interactively</span>
      </div>
    </header>
  )
}
