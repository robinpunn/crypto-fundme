import styles from "../../styles/FundMe.module.css"

export default function Buttons() {
    return (
        <article className={styles.buttons}>
            <button>Donate</button>
            <button>Withdraw</button>
        </article>
    )
}