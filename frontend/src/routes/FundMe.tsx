import Info from "../components/fundme/Info"
import Buttons from "../components/fundme/Buttons"
import Donations from "../components/fundme/Donations"
import styles from "../styles/FundMe.module.css"

function FundMe() {
    return (
        <section className={styles.fundme}>
            <Info />
            <Buttons />
            <Donations />
        </section>
    )
}

export default FundMe