import React from 'react';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Title,
  Tooltip,
  Legend
} from 'chart.js';

ChartJS.register(
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Title,
  Tooltip,
  Legend
);

const App: React.FC = () => {
  const data = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    datasets: [
      {
        label: 'Prix Crypto',
        data: [65, 59, 80, 81, 56, 55, 40, 65, 59, 80, 85, 110],
        fill: false,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1

      }
    ]
  };

  return (
    <div className="min-h-screen bg-gray-100 p-4">
      <header className="text-center my-4">
        <h1 className="text-3xl font-bold">Demo Binance MVP</h1>
      </header>
      <main>
        <section className="mb-8">
          <h2 className="text-xl font-semibold mb-2">Graphique Interactif</h2>
          <Line data={data} />
        </section>
        <section>
          <p>
            Bienvenue sur le frontend du MVP Demo Binance, construit avec Vite, React 18 et Tailwind CSS.
          </p>
        </section>
      </main>
    </div>
  );
};

export default App;
