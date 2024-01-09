import styles from "../styles/Address.module.css"
import CreatedContracts from "../components/address/CreatedContracts"
import DonatedContracts from "../components/address/DonatedContracts"
import Info from "../components/address/Info"

function Address() {
    return (
        <section className={styles.address}>
            <Info />
            <article className={styles.contracts}>
                <CreatedContracts />
                <DonatedContracts />
            </article>
        </section>
    )
}

export default Address