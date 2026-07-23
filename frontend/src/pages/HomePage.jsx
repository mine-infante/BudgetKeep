import '../styles/HomePage.css'

function HomePage() {
  return (
    <main className="app-shell">
      <section className="hero" aria-labelledby="budgetkeep-title">
        <p className="application-name">BudgetKeep</p>
        <h1 id="budgetkeep-title" className="hero-title">Take control of your finances.</h1>
        <p className="intro">Plan your budget. Track your expenses. Achieve your financial goals.</p>
      </section>
    </main>
  )
}

export default HomePage
