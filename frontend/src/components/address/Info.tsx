import styles from "../../styles/Address.module.css"

function Info() {
    return (
        <article className={styles.info}>
            <p className={styles.welcome}>Welcome</p>
            <p>This page lists all of the contracts you have created or donated to.</p>
            <p>Click on the address to navigate to that contract</p>
        </article>
    )
}

export default Info