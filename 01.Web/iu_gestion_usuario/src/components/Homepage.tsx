import React, {useState, useEffect} from 'react';
import {PlusCircle, HomeIcon, UserCircle2, Settings, Search, ArrowUpRight, ArrowDownLeft} from 'lucide-react';
import {generateClient} from 'aws-amplify/api';
import {GraphQLResult} from '@aws-amplify/api-graphql';

interface Transaction {
    id: number;
    type: 'ingreso' | 'gasto';
    amount: number;
    description: string;
    category?: string;
    date: string;
    currency?: string;
}

interface HomepageProps {
    userData: {
        username: string;
        email: string;
    };
    onNavigateToProfile: () => void;
    onNavigateToSettings: () => void;
}

interface TransactionResponse {
    listTransacciones: Array<{
        categoria_transaccion: string;
        fecha: string;
        monto: number;
        nota: string;
        tipo_moneda: string;
        tipo_transaccion: string;
    }>;
}

const client = generateClient();

const LIST_TRANSACTIONS = /* GraphQL */ `
  query ListTransacciones($gmail: String!) {
    listTransacciones(gmail: $gmail) {
      categoria_transaccion
      fecha
      monto
      nota
      tipo_moneda
      tipo_transaccion
    }
  }
`;

const Homepage: React.FC<HomepageProps> = ({userData, onNavigateToProfile, onNavigateToSettings}) => {
    const [selectedIndex, setSelectedIndex] = useState(0);
    const [balance, setBalance] = useState(1000);
    const [showAddMoney, setShowAddMoney] = useState(false);
    const [amount, setAmount] = useState('');
    const [searchTerm, setSearchTerm] = useState('');
    const [transactions, setTransactions] = useState<Transaction[]>([]);

    useEffect(() => {
        fetchTransactions();
    }, [userData.email]);

    const fetchTransactions = async () => {
        try {
            const response = await client.graphql({
                query: LIST_TRANSACTIONS,
                variables: {
                    gmail: userData.email
                }
            }) as GraphQLResult<TransactionResponse>;

            if (response.data?.listTransacciones) {
                const mappedTransactions = response.data.listTransacciones.map((tx, index) => ({
                    id: index + 1,
                    type: tx.tipo_transaccion.toLowerCase() === 'ingreso' ? 'ingreso' as 'ingreso' : 'gasto' as 'gasto',
                    amount: tx.monto,
                    description: tx.categoria_transaccion,
                    category: tx.categoria_transaccion,
                    date: tx.fecha,
                    currency: tx.tipo_moneda
                }));

                setTransactions(mappedTransactions);

                const totalBalance = mappedTransactions.reduce((acc, tx) => {
                    return acc + (tx.type === 'ingreso' ? tx.amount : -tx.amount);
                }, 0);

                setBalance(totalBalance);
            }
        } catch (error) {
            console.error('Error fetching transactions:', error);
        }
    };

    const handleAddMoney = async (e: React.FormEvent) => {
        e.preventDefault();
        const newAmount = parseFloat(amount);
        if (!isNaN(newAmount) && newAmount > 0) {
            setBalance(prevBalance => prevBalance + newAmount);
            const newTransaction: Transaction = {
                id: Date.now(),
                type: 'ingreso',
                amount: newAmount,
                description: 'Depósito',
                date: new Date().toISOString().split('T')[0]
            };
            setTransactions(prevTransactions => [newTransaction, ...prevTransactions]);
            setAmount('');
            setShowAddMoney(false);
        }
    };

    const handleNavigation = (index: number) => {
        setSelectedIndex(index);
        switch (index) {
            case 0: // Home
                break;
            case 1: // Profile
                onNavigateToProfile();
                break;
            case 2: // Settings
                onNavigateToSettings();
                break;
        }
    };

    const filteredTransactions = transactions.filter(transaction =>
        transaction.description.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="homepage-container">
            <div className="homepage-content">
                {/* Header Section */}
                <header className="homepage-header">
                    <h1>Hola,</h1>
                    <h2>{userData.username}</h2>
                </header>

                {/* Search Bar */}
                <div className="search-container">
                    <Search className="search-icon" size={24}/>
                    <input
                        type="text"
                        placeholder="Buscar transacciones"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="search-input"
                    />
                </div>

                {/* Balance Card */}
                <div className="balance-card">
                    <div className="flex justify-between items-center">
                        <div>
                            <p className="text-white text-lg">Dinero total</p>
                            <p className="text-white text-4xl font-bold mt-2">S/{balance.toFixed(2)}</p>
                        </div>
                        <button onClick={() => setShowAddMoney(!showAddMoney)}>
                            <PlusCircle className="text-white h-12 w-12 hover:opacity-80"/>
                        </button>
                    </div>
                    {showAddMoney && (
                        <form onSubmit={handleAddMoney} className="mt-4">
                            <input
                                type="number"
                                value={amount}
                                onChange={(e) => setAmount(e.target.value)}
                                placeholder="Monto a agregar"
                                className="w-full p-2 rounded-md bg-white text-gray-900"
                                min="0"
                                step="0.01"
                                required
                            />
                            <button type="submit"
                                    className="mt-2 w-full bg-white text-blue-500 p-2 rounded-md hover:bg-blue-100">
                                Agregar dinero
                            </button>
                        </form>
                    )}
                </div>

                {/* Transactions */}
                <h3 className="section-title">Transacciones recientes</h3>
                <div>
                    {filteredTransactions.map((transaction) => (
                        <div
                            key={transaction.id}
                            className={`transaction-card ${
                                transaction.type === 'ingreso' ? 'transaction-positive' : 'transaction-negative'
                            }`}
                        >
                            <div className="flex items-center">
                                <div className="transaction-icon">
                                    {transaction.type === 'ingreso' ? (
                                        <ArrowDownLeft size={24}/>
                                    ) : (
                                        <ArrowUpRight size={24}/>
                                    )}
                                </div>
                                <div>
                                    <p className="transaction-description">{transaction.description}</p>
                                    <p className="transaction-date">{transaction.date}</p>
                                </div>
                            </div>
                            <span className="transaction-amount">
                {transaction.type === 'ingreso' ? '+' : '-'}S/{transaction.amount.toFixed(2)}
              </span>
                        </div>
                    ))}
                </div>

                {/* Bottom Navigation */}
                <nav className="bottom-nav">
                    <div className="nav-buttons">
                        {[
                            {icon: HomeIcon, label: 'Inicio'},
                            {icon: UserCircle2, label: 'Perfil'},
                            {icon: Settings, label: 'Configuración'},
                        ].map((item, index) => (
                            <button
                                key={item.label}
                                onClick={() => handleNavigation(index)}
                                className={`nav-button ${selectedIndex === index ? 'active' : 'inactive'}`}
                            >
                                <item.icon size={24}/>
                                <span className="text-xs mt-1">{item.label}</span>
                            </button>
                        ))}
                    </div>
                </nav>
            </div>
        </div>
    );
};

export default Homepage;