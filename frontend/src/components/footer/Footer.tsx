import styles from '../../styles/Footer.module.css'

function Footer() {
    return (
        <section className={styles.footer}>
            <h4>created by <a className={styles.footerLink} target="_blank" rel="noopener noreferrer" href="https://github.com/robinpunn">robinpunn</a></h4>
        </section>
    )
}

export default Footer