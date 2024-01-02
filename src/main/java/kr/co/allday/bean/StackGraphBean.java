package kr.co.allday.bean;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StackGraphBean {
	private String label;
    private List<Integer> values;
}
