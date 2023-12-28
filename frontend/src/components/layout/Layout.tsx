import React, { ReactNode } from 'react'
import styles from "../../styles/Layout.module.css"
import Navbar from '../navbar/Navbar'
import Footer from '../footer/Footer'

interface LayoutProps {
    children: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
    return (
        <>
            <Navbar />
            <div className={styles.container}>{children}</div>
            <Footer />
        </>
    )
}

export default Layout