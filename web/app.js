// Simple Golf Scores app using localStorage
(function(){
  const key = 'golf_rounds_v1'
  const dateEl = document.getElementById('date')
  const courseEl = document.getElementById('course')
  const holesEl = document.getElementById('holes')
  const scoreEl = document.getElementById('score')
  const slopeEl = document.getElementById('slope')
  const ratingEl = document.getElementById('rating')
  const addBtn = document.getElementById('add')
  const listEl = document.getElementById('rounds')

  let rounds = []

  function load(){
    try{ rounds = JSON.parse(localStorage.getItem(key)) || [] }catch(e){ rounds = [] }
  }

  function save(){ localStorage.setItem(key, JSON.stringify(rounds)) }

  function formatDate(iso){
    const d = new Date(iso)
    return d.toLocaleDateString()
  }

  function render(){
    listEl.innerHTML = ''
    rounds.forEach(r => {
      const li = document.createElement('li')
      li.className = 'round-item'
      li.innerHTML = `<div>
        <div><strong>${escapeHtml(r.course)}</strong></div>
        <div class="meta">${formatDate(r.date)}</div>
      </div>
        <div style="text-align:right">
        <div>Holes: ${r.holes}</div>
        <div><strong>Score: ${r.score}</strong></div>
        <div>Slope: ${r.slope !== undefined ? r.slope : '—'}</div>
        <div>Rating: ${r.rating !== undefined ? r.rating : '—'}</div>
        <div style="margin-top:8px"><button class="del" data-id="${r.id}">Delete</button></div>
      </div>`
      listEl.appendChild(li)
    })
  }

  function addRound(){
    const course = courseEl.value.trim()
    if(!course) return alert('Enter course name')
    const date = dateEl.value || new Date().toISOString().slice(0,10)
    const holes = parseInt(holesEl.value,10)||18
    const score = parseInt(scoreEl.value,10)||72
    const slope = parseInt(slopeEl.value,10) || 113
    const rating = parseFloat(ratingEl.value) || 72.0
    const round = { id: Date.now(), date, course, holes, score, slope, rating }
    rounds.unshift(round)
    save()
    render()
    courseEl.value = ''
    slopeEl.value = 113
    ratingEl.value = 72.0
  }

  function deleteRound(id){
    rounds = rounds.filter(r => r.id !== Number(id))
    save()
    render()
  }

  function escapeHtml(s){ return String(s).replace(/[&<>\"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c])) }

  addBtn.addEventListener('click', addRound)
  listEl.addEventListener('click', e => {
    if(e.target.matches('.del')) deleteRound(e.target.dataset.id)
  })

  // init default date to today
  dateEl.value = new Date().toISOString().slice(0,10)
  load(); render();
})();
