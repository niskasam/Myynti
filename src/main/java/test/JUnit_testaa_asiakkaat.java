package test;

import static org.junit.Assert.assertEquals;
import java.util.ArrayList;
import org.junit.Test;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.TestMethodOrder;
import model.Myynti;
import model.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
public class JUnit_testaa_asiakkaat {
	
	@Test
	@Order(1)
	public void testPoistaKaikkiAsiakkaat() {
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("del8cu5t!");
		ArrayList<Myynti> asiakkaat = dao.listaaAsiakkaat();
		assertEquals(0, asiakkaat.size());

	}
	
}
