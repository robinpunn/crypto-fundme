import styles from "../../styles/Address.module.css"

const createdContractsData = [
    { id: 1, contractAddress: "0x00000", funded: 10 },
    { id: 2, contractAddress: "0x00000", funded: 300 }
]

function CreatedContracts() {
    return (
        <article className={styles.created}>
            <h3>Created Contracts</h3>
            <ul>
                {createdContractsData.map(contract => (
                    <li key={contract.id}>
                        Address: {contract.contractAddress},
                        Funded:  {contract.funded}
                    </li>
                ))}
            </ul>
        </article>
    )
}

export default CreatedContracts