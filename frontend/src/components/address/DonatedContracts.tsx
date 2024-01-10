import styles from "../../styles/Address.module.css"

const donatedContractsData = [
    { id: 1, contractAddress: "0x00000", donated: 0.5 },
    { id: 2, contractAddress: "0x00000", donated: 0.25 }
]

function DonatedContracts() {
    return (
        <div className={styles.donated}>
            <h3>Donated Contracts</h3>
            <table className={styles.table}>
                <thead>
                    <tr>
                        <th>Address</th>
                        <th>Donated</th>
                    </tr>
                </thead>
                <tbody>
                    {donatedContractsData.map(contract => (
                        <tr key={contract.id}>
                            <td>{contract.contractAddress}</td>
                            <td>{contract.donated}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    )
}

export default DonatedContracts