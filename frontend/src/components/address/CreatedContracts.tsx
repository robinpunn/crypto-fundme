import styles from "../../styles/Address.module.css"

const createdContractsData = [
    { id: 1, contractAddress: "0x00000", funded: 10 },
    { id: 2, contractAddress: "0x00000", funded: 300 }
]

function CreatedContracts() {
    return (
        <div className={styles.created}>
            <h3>Created Contracts</h3>
            <table className={styles.table}>
                <thead>
                    <tr>
                        <th>Address</th>
                        <th>Funded</th>
                    </tr>
                </thead>
                <tbody>
                    {createdContractsData.map(contract => (
                        <tr key={contract.id}>
                            <td>{contract.contractAddress}</td>
                            <td>{contract.funded}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    )
}

export default CreatedContracts