import { Outlet } from 'react-router-dom'
import Header from './Header'
import Sidebar from './Sidebar'
import { usePlaygroundStore } from '../../store/store'

export default function MainLayout() {
  const { sidebarOpen } = usePlaygroundStore()

  return (
    <div className="h-screen flex flex-col bg-sql-darker">
      <Header />
      <div className="flex-1 flex overflow-hidden">
        {sidebarOpen && <Sidebar />}
        <main className="flex-1 overflow-auto">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
