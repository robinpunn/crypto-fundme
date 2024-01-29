import styles from "../../styles/FundMe.module.css"

export default function Donations() {
    return (
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
    )
}
