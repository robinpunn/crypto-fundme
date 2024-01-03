import styles from "../../styles/Address.module.css"

const donatedContractsData = [
    { id: 1, contractAddress: "0x00000", donated: 0.5 },
    { id: 2, contractAddress: "0x00000", donated: 0.25 }
]

function DonatedContracts() {
    return (
        <article className={styles.donated}>
            <h3>Donated Contracts</h3>
            <ul>
                {donatedContractsData.map(contract => (
                    <li key={contract.id}>
                        Address: {contract.contractAddress},
                        Funded:  {contract.donated}
                    </li>
                ))}
            </ul>
        </article>
    )
}

export default DonatedContracts