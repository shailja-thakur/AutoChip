	
	assign fan = (mode ? too_cold : too_hot) | fan_on;
	assign heater = (mode & too_cold);
	assign aircon = (~mode & too_hot);
	
endmodule
