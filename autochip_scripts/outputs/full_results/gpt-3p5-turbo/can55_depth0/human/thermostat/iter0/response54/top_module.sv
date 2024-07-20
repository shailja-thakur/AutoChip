module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Declare internal variable
    reg fan_on_internal;
    
    // Determine if fan should be on based on requested fan_on input or heater/aircon being on
    always @* begin
        if (fan_on == 1 || heater == 1 || aircon == 1)
            fan_on_internal = 1;
        else
            fan_on_internal = 0;
    end
    
    // Control the heater, aircon, and fan based on the mode, too_cold, and too_hot inputs
    always @* begin
        if (mode == 1) begin
            if (too_cold == 1) begin
                heater = 1;
                aircon = 0;
            end
            else begin
                heater = 0;
                aircon = 0;
            end
        end
        else begin
            if (too_hot == 1) begin
                heater = 0;
                aircon = 1;
            end
            else begin
                heater = 0;
                aircon = 0;
            end
        end
    end
    
    // Output the fan state
    assign fan = fan_on_internal;
    
endmodule
