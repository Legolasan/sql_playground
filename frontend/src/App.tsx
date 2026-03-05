import { Routes, Route } from 'react-router-dom'
import MainLayout from './components/Layout/MainLayout'
import Playground from './pages/Playground'
import Challenges from './pages/Challenges'
import Progress from './pages/Progress'

function App() {
  return (
    <Routes>
      <Route path="/" element={<MainLayout />}>
        <Route index element={<Playground />} />
        <Route path="challenges" element={<Challenges />} />
        <Route path="challenges/:id" element={<Playground />} />
        <Route path="progress" element={<Progress />} />
      </Route>
    </Routes>
  )
}

export default App
