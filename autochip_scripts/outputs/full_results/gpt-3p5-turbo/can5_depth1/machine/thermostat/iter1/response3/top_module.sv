module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Control the fan
    assign fan = (fan_on || too_cold || too_hot);
    
    // Control the heater
    assign heater = (mode && too_cold);
    
    // Control the air conditioner
    assign aircon = (!mode && too_hot);
    
    initial begin
        // Simulate inputs
        mode = 0; too_cold = 0; too_hot = 0; fan_on = 0;
        
        // Wait for a few cycles
        #10;
        
        // Change input values
        mode = 1; too_cold = 1;
        
        // Wait for a few more cycles
        #10;
        
        // Change input values
        mode = 0; too_hot = 1;
        
        // Wait for a few more cycles
        #10;
        
        // Change input values
        too_cold = 0; too_hot = 0; fan_on = 1;
        
        // Wait for a few more cycles
        #10;
        
        // Finish simulation
        $finish;
    end
    
endmodule
