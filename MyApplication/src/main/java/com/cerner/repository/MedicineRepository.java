package com.cerner.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cerner.model.Medicine;

/**
 * The Interface MedicineRepository.
 * @author PD078416
 */
/*A repository is a mechanism for encapsulating storage, 
retrieval, and search behavior which matches a collection of objects.*/
@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Integer>,CrudRepository<Medicine,Integer>{

	
	/**
	 * Find all medicines.
	 *
	 * @return the list of medicines
	 */
	//custom query can be provided using @Query annotation.
	@Query(value="select * from medicine",nativeQuery = true)
	public List<Medicine> findAllMedicines();
	
	/**
	 * Find stocks.
	 *
	 * @param id the medicine id
	 * @return the medicine stocks for the passed medicine id
	 */
	@Query(value="select stocks from medicine where medicine_id=:id",nativeQuery=true)
	public int findStocks(@Param("id") int id);
	
	/**
	 * Update medicine stocks.
	 *
	 * @param id the medicine id
	 * @return the status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
	@Query(value="update medicine set stocks=stocks-1 where medicine_id=:id", nativeQuery=true)
	public int updateMedicineStocks(@Param("id") int id);

	/**
	 * Delete medicines.
	 *
	 * @param id the id
	 */
	@Modifying
	@Transactional
	@Query(value="delete from medicine where medicine_id=:id", nativeQuery=true)
	public void deleteMedicines(@Param("id") int id);
	
	
	/**
	 * Edits the medicine stocks.
	 *
	 * @param id the medicine id
	 * @param quantity the medicine intake quantity
	 */
	@Modifying
	@Transactional
	@Query(value="update medicine set stocks=stocks - :quantity where medicine_id=:id",nativeQuery=true)
	public void editMedicineStocks(@Param("id")int id,@Param("quantity")int quantity);

	/**
	 * Update stocks.
	 *
	 * @param id the medicine id
	 * @param stocks the medicine stocks
	 */
	@Modifying
	@Transactional
	@Query(value="update medicine set stocks=stocks + :stocks where medicine_id=:id",nativeQuery=true)
	public void updateStocks(@Param("id") int id, @Param("stocks") int stocks);
	
	@Modifying
	@Transactional
	@Query(value="insert into medicine(medicine_name,stocks) values(:medicineName,:stocks)",nativeQuery=true)
	public void addMedicine(@Param("medicineName") String medicineName,@Param("stocks") int stocks);
	
	@Query(value="select * from medicine where medicine_name=:medicineName",nativeQuery=true)
	public Medicine searchMedicine(@Param("medicineName") String medicineName);
}