import styles from "../../styles/Address.module.css"

type CreatedContractsData = {
    id: number;
    contractAddress: string;
    funded: number;
}

const createdContractsData: CreatedContractsData[] = [
    // { id: 1, contractAddress: "0x00000", funded: 10 },
    // { id: 2, contractAddress: "0x00000", funded: 300 }
]

function CreatedContracts() {
    return (
        <div className={styles.created}>
            <h3>Created Contracts</h3>
            {createdContractsData.length > 0 ? (
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
            ) : (
                <p className={styles.none}>No contracts created</p>
            )}
        </div>
    )
}

export default CreatedContracts