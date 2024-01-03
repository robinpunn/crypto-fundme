import styles from "../styles/Address.module.css"
import CreatedContracts from "../components/address/CreatedContracts"
import DonatedContracts from "../components/address/DonatedContracts"

function Address() {
    return (
        <section className={styles.address}>
            <CreatedContracts />
            <DonatedContracts />
        </section>
    )
}

export default Address