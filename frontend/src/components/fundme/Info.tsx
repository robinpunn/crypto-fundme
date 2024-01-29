import styles from "../../styles/FundMe.module.css"

export default function Info() {
    return (
        <article className={styles.info}>
            <h3 className={styles.owner}>Owner: </h3>
            <h3 className={styles.contract}>Contract: </h3>
            <h3 className={styles.raised}>Amount Raised: </h3>
        </article>
    )
}
