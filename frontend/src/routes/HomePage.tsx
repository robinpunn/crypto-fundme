import styles from '../styles/Home.module.css'

function HomePage() {
    return (
        <section className={styles.homePage}>
            <article className={styles.intro}>
                <div>
                    This app allows users to participate in crowd funding using the Ethereum blockchain. Currently deployed on the Sepolia testnet, users have the option to create contracts and donate ether to contracts.
                </div>
            </article>

            <article className={styles.info}>
                <div className={styles.create}>
                    <h2>CREATE</h2>
                    <p>Create a contract and become its owner</p>
                    <p>Withdraw at any time</p>
                </div>
                <div className={styles.donate}>
                    <h2>DONATE</h2>
                    <p>Donate Eth to any contract</p>
                    <p>Browse contracts </p>
                </div>
            </article>
        </section>
    )
}

export default HomePage