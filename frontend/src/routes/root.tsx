import '@rainbow-me/rainbowkit/styles.css';
import { Route, Routes } from 'react-router-dom';
import {
    getDefaultWallets,
    RainbowKitProvider,
} from '@rainbow-me/rainbowkit';
import { configureChains, createConfig, WagmiConfig } from 'wagmi';
import {
    sepolia,
    mainnet,
    polygon,
    optimism,
    arbitrum,
    base,
    zora,
} from 'wagmi/chains';
import { alchemyProvider } from 'wagmi/providers/alchemy';
import { publicProvider } from 'wagmi/providers/public';

import Layout from '../components/layout/Layout';
import HomePage from './HomePage';
import Address from './Address';
import FundMe from './FundMe';

const alchemyApiKey = import.meta.env.VITE_ALCHEMY_ID;

const { chains, publicClient } = configureChains(
    [
        sepolia, mainnet, polygon, optimism, arbitrum, base, zora],
    [
        alchemyProvider({ apiKey: alchemyApiKey }),
        publicProvider()
    ]
);

const { connectors } = getDefaultWallets({
    appName: 'My RainbowKit App',
    projectId: 'YOUR_PROJECT_ID',
    chains
});

const wagmiConfig = createConfig({
    autoConnect: true,
    connectors,
    publicClient
})

const Root = () => {
    return (
        <WagmiConfig config={wagmiConfig}>
            <RainbowKitProvider chains={chains}>
                <Layout>
                    <Routes>
                        <Route path='/' element={<HomePage />} />
                        <Route path='/address' element={<Address />} />
                        <Route path='/fundme' element={<FundMe />} />
                    </Routes>
                </Layout>
            </RainbowKitProvider>
        </WagmiConfig>
    );
};

export default Root
