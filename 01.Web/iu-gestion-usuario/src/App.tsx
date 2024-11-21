import React, { useState } from 'react';
import { ThemeProvider, createTheme, CssBaseline, Container, Box, Button } from '@mui/material';
import LoginForm from './components/login';
import RegisterForm from './components/register';
import Profile from './components/profile';
import ManejoDatos from './components/manejodatos';
import './App.css';
import ReactDOM from 'react-dom';

import './index.css';

const theme = createTheme();

type View = 'login' | 'register' | 'profile' | 'manejoDatos';

interface UserData {
  username: string;
  email: string;
  avatarUrl?: string;
}

function App() {
  const [currentView, setCurrentView] = useState<View>('login');
  const [userData, setUserData] = useState<UserData | null>(null);

  const handleLogin = (email: string, password: string) => {
    console.log('Intento de login con:', email, password);
    // Simulating a successful login
    setUserData({ username: 'Usuario de Prueba', email: email });
    setCurrentView('profile');
  };

  const handleRegister = (name: string, email: string, password: string) => {
    console.log('Intento de registro con:', name, email, password);
    // Simulating a successful registration
    setUserData({ username: name, email: email });
    setCurrentView('profile');
  };

  const handleForgotPassword = () => {
    console.log('Recuperar contraseña');
  };

  const handleManejoDatos = () => {
    setCurrentView('manejoDatos');
  };

  const handleLogout = () => {
    setUserData(null);
    setCurrentView('login');
  };

  const handleDeleteAccount = () => {
    console.log('Cuenta borrada');
    setUserData(null);
    setCurrentView('login');
  };

  const renderView = () => {
    switch (currentView) {
      case 'login':
        return (
          <LoginForm 
            onSubmit={handleLogin}
            onForgotPassword={handleForgotPassword}
            onRegister={() => setCurrentView('register')}
          />
        );
      case 'register':
        return (
          <RegisterForm 
            onSubmit={handleRegister}
            onLogin={() => setCurrentView('login')}
          />
        );
      case 'profile':
        return userData ? (
          <Profile 
            onManejoDatos={handleManejoDatos}
            onLogout={handleLogout}
            onDeleteAccount={handleDeleteAccount}
            userData={userData}
          />
        ) : null;
      case 'manejoDatos':
        return <ManejoDatos />;
    }
  };

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Container component="main" maxWidth="md">
        <Box
          sx={{
            marginTop: 8,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
          }}
        >
          {renderView()}
          {currentView === 'manejoDatos' && (
            <Button 
              onClick={() => setCurrentView('profile')} 
              sx={{ mt: 2 }}
            >
              Volver al Perfil
            </Button>
          )}
        </Box>
      </Container>
    </ThemeProvider>
  );
}
const rootElement = document.getElementById('app');
if (!rootElement) throw new Error('Error al encontrar el elemento raíz');

ReactDOM.render(<App />, rootElement);

export default App;