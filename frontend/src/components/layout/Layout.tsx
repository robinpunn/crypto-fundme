import React from 'react'
import styles from "../../styles/Layout.module.css"

const Layout = ({ children }) => {
    return (
        <>
            <Navbar />
            <div>{children}</div>
            <Footer />
        </>
    )
}

export default Layout