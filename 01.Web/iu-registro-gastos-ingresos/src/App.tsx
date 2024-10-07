import './index.scss'
import React, { useState } from 'react'
import ReactDOM from 'react-dom/client'
import { Button } from "../@/components/ui/button"
import { Input } from "../@/components/ui/input"
import { Label } from "../@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../@/components/ui/select"
import { Textarea } from "../@/components/ui/textarea"
import { RadioGroup, RadioGroupItem } from "../@/components/ui/radio-group"
import { Calendar as CalendarIcon, Camera, ArrowLeft } from 'lucide-react'
import { format } from "date-fns"
import { Calendar } from "../@/components/ui/calendar"
import { Popover, PopoverContent, PopoverTrigger } from "../@/components/ui/popover"

const EntradaGastoIngreso = () => {
  const [fecha, setFecha] = useState<Date | undefined>(undefined)

  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 p-4">
      <header className="flex items-center mb-6">
        <Button variant="ghost" size="icon" className="mr-2">
          <ArrowLeft className="h-6 w-6" />
        </Button>
        <h1 className="text-2xl font-bold">Agregar Transacción</h1>
      </header>

      <form className="space-y-6">
        <div className="space-y-2">
          <Label>Tipo de Transacción</Label>
          <RadioGroup defaultValue="gasto" className="flex space-x-4">
            <div className="flex items-center space-x-2">
              <RadioGroupItem value="gasto" id="gasto" />
              <Label htmlFor="gasto">Gasto</Label>
            </div>
            <div className="flex items-center space-x-2">
              <RadioGroupItem value="ingreso" id="ingreso" />
              <Label htmlFor="ingreso">Ingreso</Label>
            </div>
          </RadioGroup>
        </div>

        <div className="space-y-2">
          <Label htmlFor="monto">Monto</Label>
          <Input id="monto" type="number" placeholder="0.00" className="bg-gray-800 border-gray-700" />
        </div>

        <div className="space-y-2">
          <Label htmlFor="categoria">Categoría</Label>
          <Select>
            <SelectTrigger className="bg-gray-800 border-gray-700">
              <SelectValue placeholder="Selecciona una categoría" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="alimentacion">Alimentación</SelectItem>
              <SelectItem value="transporte">Transporte</SelectItem>
              <SelectItem value="vivienda">Vivienda</SelectItem>
              <SelectItem value="servicios">Servicios</SelectItem>
              <SelectItem value="entretenimiento">Entretenimiento</SelectItem>
              <SelectItem value="otro">Otro</SelectItem>
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-2">
          <Label>Fecha</Label>
          <Popover>
            <PopoverTrigger asChild>
              <Button
                variant={"outline"}
                className={`w-full justify-start text-left font-normal bg-gray-800 border-gray-700 ${!fecha && "text-muted-foreground"}`}
              >
                <CalendarIcon className="mr-2 h-4 w-4" />
                {fecha ? format(fecha, "PPP") : <span>Elige una fecha</span>}
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-auto p-0 bg-gray-800 border-gray-700">
              <Calendar
                mode="single"
                selected={fecha}
                onSelect={setFecha}
                initialFocus
              />
            </PopoverContent>
          </Popover>
        </div>

        <div className="space-y-2">
          <Label htmlFor="notas">Notas</Label>
          <Textarea id="notas" placeholder="Agrega detalles adicionales..." className="bg-gray-800 border-gray-700" />
        </div>

        <div className="space-y-2">
          <Label>Adjuntar Recibo</Label>
          <div className="flex items-center space-x-2">
            <Button variant="outline" className="bg-gray-800 border-gray-700">
              <Camera className="h-4 w-4 mr-2" />
              Tomar Foto
            </Button>
            <Button variant="outline" className="bg-gray-800 border-gray-700">
              Subir Imagen
            </Button>
          </div>
        </div>

        <Button className="w-full">Guardar Transacción</Button>
      </form>
    </div>
  )
}

const App = () => (
  <EntradaGastoIngreso />
)

const rootElement = document.getElementById('app')
if (!rootElement) throw new Error('Error al encontrar el elemento raíz')

const root = ReactDOM.createRoot(rootElement)

root.render(<App />)

export default App