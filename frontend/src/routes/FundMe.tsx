import styles from "../styles/FundMe.module.css"

function FundMe() {
    return (
        <section className={styles.fundme}>
            <article className={styles.info}>
                <h3 className={styles.owner}>Owner: </h3>
                <h3 className={styles.contract}>Contract: </h3>
                <h3 className={styles.raised}>Amount Raised: </h3>
            </article>

            <article className={styles.buttons}>
                <button>Donate</button>
                <button>Withdraw</button>
            </article>

            <article className={styles.donated}>
                <h3>Donations</h3>
                <table className={styles.table}>
                    <thead>
                        <tr>
                            <th>Address</th>
                            <th>Donated</th>
                            <th>Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Random Address</td>
                            <td>0.5 ETH</td>
                            <td>Random Comment</td>
                        </tr>
                    </tbody>
                </table>
            </article>
        </section>
    )
}

export default FundMe