import {useState, useEffect} from 'react';
import LoginForm from './components/login';
import RegisterForm from './components/register';
import Profile from './components/profile';
import ManejoDatos from './components/manejodatos';
import Homepage from './components/Homepage';

import './App.css';
import './index.css';
import {generateClient} from 'aws-amplify/api';
import {Amplify} from 'aws-amplify';
import {GraphQLResult} from '@aws-amplify/api-graphql';

// Amplify Configuration
Amplify.configure({
    API: {
        GraphQL: {
            endpoint: import.meta.env.VITE_APP_APPSYNC_ENDPOINT,
            region: import.meta.env.VITE_APP_AWS_REGION,
            defaultAuthMode: 'apiKey',
            apiKey: import.meta.env.VITE_APP_API_KEY
        }
    }
});

const client = generateClient();

interface AuthResponse {
    autenticarUsuario: {
        App: boolean;
        Pasword: string;
        Correo: boolean;
        Nombre: string;
        Resumen: boolean;
    }
}

const AUTH_QUERY = `
  query MyQuery($gmail: String!, $password: String!) {
    autenticarUsuario(Gmail: $gmail, Pasword: $password) {
      App
      Pasword
      Correo
      Nombre
      Resumen
    }
  }
`;

type View = 'login' | 'register' | 'profile' | 'manejoDatos' | 'homepage';

interface UserData {
    username: string;
    email: string;
    avatarUrl?: string;
}

function IUGestionUsuario() {
    const [currentView, setCurrentView] = useState<View>(() => {
        // Inicializar currentView desde localStorage
        const savedView = localStorage.getItem('currentView');
        return (savedView as View) || 'login';
    });

    const [userData, setUserData] = useState<UserData | null>(() => {
        // Inicializar userData desde localStorage
        const savedUserData = localStorage.getItem('userData');
        return savedUserData ? JSON.parse(savedUserData) : null;
    });

    const [error, setError] = useState<string>('');

    // Guardar cambios en localStorage cuando el estado cambie
    useEffect(() => {
        if (userData) {
            localStorage.setItem('userData', JSON.stringify(userData));
            localStorage.setItem('currentView', currentView);
        } else {
            localStorage.removeItem('userData');
            localStorage.removeItem('currentView');
        }
    }, [userData, currentView]);

    const handleLogin = async (email: string, password: string) => {
        try {
            const response = await client.graphql({
                query: AUTH_QUERY,
                variables: {
                    gmail: email,
                    password: password
                }
            }) as GraphQLResult<AuthResponse>;

            if (response.data?.autenticarUsuario?.Nombre) {
                const newUserData = {
                    username: response.data.autenticarUsuario.Nombre,
                    email: email
                };
                setUserData(newUserData);
                setCurrentView('homepage');
                setError('');
            } else {
                setError('Credenciales inválidas');
            }
        } catch (error) {
            console.error('Error durante la autenticación:', error);
            setError('Error al intentar iniciar sesión');
        }
    };

    const handleRegister = (name: string, email: string, password: string) => {
        console.log('Intento de registro con:', name, email, password);
        setUserData({username: name, email: email});
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
        localStorage.removeItem('userData');
        localStorage.removeItem('currentView');
    };

    const handleDeleteAccount = () => {
        console.log('Cuenta borrada');
        setUserData(null);
        setCurrentView('login');
        localStorage.removeItem('userData');
        localStorage.removeItem('currentView');
    };

    const renderView = () => {
        switch (currentView) {
            case 'login':
                return (
                    <div className="max-w-2xl mx-auto mt-8 flex flex-col items-center">
                        {error && <div className="text-red-500 mb-4">{error}</div>}
                        <LoginForm
                            onSubmit={handleLogin}
                            onForgotPassword={handleForgotPassword}
                            onRegister={() => setCurrentView('register')}
                        />
                    </div>
                );
            case 'register':
                return (
                    <div className="max-w-2xl mx-auto mt-8 flex flex-col items-center">
                        <RegisterForm
                            onSubmit={handleRegister}
                            onLogin={() => setCurrentView('login')}
                        />
                    </div>
                );
            case 'homepage':
                return userData ? (
                    <div className="w-full">
                        <Homepage
                            userData={userData}
                            onNavigateToProfile={() => setCurrentView('profile')}
                            onNavigateToSettings={() => setCurrentView('manejoDatos')}
                        />
                    </div>
                ) : null;
            case 'profile':
                return userData ? (
                    <div className="max-w-2xl mx-auto mt-8 flex flex-col items-center">
                        <Profile
                            onManejoDatos={handleManejoDatos}
                            onLogout={handleLogout}
                            onDeleteAccount={handleDeleteAccount}
                            userData={userData}
                        />
                    </div>
                ) : null;
            case 'manejoDatos':
                return (
                    <div className="max-w-2xl mx-auto mt-8 flex flex-col items-center">
                        <ManejoDatos/>
                    </div>
                );
        }
    };

    return (
        <div className="min-h-screen bg-gray-100">
            <main className={`w-full ${currentView === 'homepage' ? 'p-0' : 'container mx-auto px-4 py-8'}`}>
                {renderView()}
                {currentView === 'manejoDatos' && (
                    <div className="max-w-2xl mx-auto mt-8 flex flex-col items-center">
                        <button
                            onClick={() => setCurrentView('profile')}
                            className="mt-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
                        >
                            Volver al Perfil
                        </button>
                    </div>
                )}
            </main>
        </div>
    );
}

export default IUGestionUsuario;