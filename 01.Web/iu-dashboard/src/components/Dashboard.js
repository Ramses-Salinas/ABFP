'use client';

import React from 'react'
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Bell, DollarSign, PieChart, Plus } from 'lucide-react'
import { PieChart as PieChartComponent, Pie, Cell, ResponsiveContainer, BarChart, Bar, XAxis, YAxis, Tooltip, Legend } from 'recharts'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"

const datosGastos = [
  { name: 'Vivienda', presupuesto: 1200, gastoActual: 1000 },
  { name: 'Alimentación', presupuesto: 600, gastoActual: 500 },
  { name: 'Transporte', presupuesto: 400, gastoActual: 300 },
  { name: 'Entretenimiento', presupuesto: 300, gastoActual: 200 },
  { name: 'Otros', presupuesto: 200, gastoActual: 150 },
]

const COLORES = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8']

export default function Dashboard() {
  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 p-4">
      <header className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 space-y-4 sm:space-y-0">
        <h1 className="text-2xl font-bold">Dashboard</h1>
        <div className="flex items-center space-x-4">
          <Select>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Seleccionar vista" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="presupuesto">Presupuesto</SelectItem>
              <SelectItem value="gasto-mensual">Gasto Mensual</SelectItem>
              <SelectItem value="resumen-general">Resumen General</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" size="icon">
            <Bell className="h-4 w-4" />
          </Button>
        </div>
      </header>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-sm">Saldo Actual</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">$3.450,00</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-sm">Progreso del Presupuesto</CardTitle>
          </CardHeader>
          <CardContent>
            <Progress value={75} className="w-full" />
            <div className="mt-2 text-xs text-gray-400">75% utilizado</div>
          </CardContent>
        </Card>
      </div>

      <Card className="mb-6">
        <CardHeader>
          <CardTitle>Presupuesto vs Gasto Actual</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={datosGastos}>
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="presupuesto" fill="#8884d8" name="Presupuesto" />
                <Bar dataKey="gastoActual" fill="#82ca9d" name="Gasto Actual" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>

      <Card className="mb-6">
        <CardHeader>
          <CardTitle>Distribución de Gastos</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <PieChartComponent>
                <Pie
                  data={datosGastos}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="gastoActual"
                >
                  {datosGastos.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORES[index % COLORES.length]} />
                  ))}
                </Pie>
              </PieChartComponent>
            </ResponsiveContainer>
          </div>
          <div className="mt-4 grid grid-cols-2 gap-2">
            {datosGastos.map((entry, index) => (
              <div key={entry.name} className="flex items-center">
                <div className="w-3 h-3 mr-2" style={{ backgroundColor: COLORES[index % COLORES.length] }}></div>
                <span className="text-sm">{entry.name}</span>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <Card className="mb-6">
        <CardHeader>
          <CardTitle>Alertas Importantes</CardTitle>
        </CardHeader>
        <CardContent>
          <ul className="space-y-2">
            <li className="flex items-center text-yellow-400">
              <Bell className="h-4 w-4 mr-2" />
              <span>Estás cerca del límite de tu presupuesto para comer fuera</span>
            </li>
            <li className="flex items-center text-green-400">
              <DollarSign className="h-4 w-4 mr-2" />
              <span>¡Buen trabajo! Has ahorrado $100 más que el mes pasado</span>
            </li>
          </ul>
        </CardContent>
      </Card>

      <div className="fixed bottom-6 right-6">
        <Button size="lg" className="rounded-full w-16 h-16">
          <Plus className="h-6 w-6" />
        </Button>
      </div>
    </div>
  )
}