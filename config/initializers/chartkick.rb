Chartkick.options = {
  library: {
    responsive: true,
    defaultFontSize: 14,
    tooltips: {
      mode: 'x-axis',
      titleFontSize: 14,
      bodyFontSize: 14
    },
    scales: {
      yAxes: [{
        ticks: {
          stepSize: 1
        }
      }]
    }
  }
}

Chartkick.options[:html] = '<div id="%{id}" style="height: %{height};">Loading...</div>'

Chartkick.options[:content_for] = :charts_js
