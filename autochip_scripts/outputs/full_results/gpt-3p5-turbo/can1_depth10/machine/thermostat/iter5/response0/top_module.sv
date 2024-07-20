module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    // Fan control
    always @(*)
    begin
        fan = fan_on || too_cold || too_hot;
    end

    // Heater control
    always @(*)
    begin
        heater = mode && too_cold;
    end

    // Aircon control
    always @(*)
    begin
        aircon = mode && too_hot;
    end

    initial begin
        // Initialize outputs
        heater = 0;
        aircon = 0;
        fan = 0;
        
        // Apply inputs
        mode = 1;
        too_cold = 0;
        too_hot = 0;
        fan_on = 0;
        
        // Delay to allow for changes to propagate
        #10;
        
        // Verify outputs
        if (fan !== (fan_on || too_cold || too_hot))
            $display("Mismatch in fan output");
            
        if (heater !== (mode && too_cold))
            $display("Mismatch in heater output");
            
        if (aircon !== (mode && too_hot))
            $display("Mismatch in aircon output");
        
        $finish;
    end

endmodule
