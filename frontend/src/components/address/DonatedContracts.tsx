import styles from "../../styles/Address.module.css"

type DonatedContract = {
    id: number;
    contractAddress: string;
    donated: number;
}

const donatedContractsData: DonatedContract[] = [
    { id: 1, contractAddress: "0x00000", donated: 0.5 },
    { id: 2, contractAddress: "0x00000", donated: 0.25 }
]

function DonatedContracts() {
    return (
        <div className={styles.donated}>
            <h3>Donated Contracts</h3>
            {donatedContractsData.length > 0 ? (
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
            ) : (
                <p className={styles.none}>No donations made</p>
            )}
        </div>
    )
}

export default DonatedContracts