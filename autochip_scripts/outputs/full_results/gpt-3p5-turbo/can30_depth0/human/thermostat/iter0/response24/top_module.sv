module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

assign fan = heater | aircon | fan_on;

always @*
begin
    if (mode == 1) // heating mode
    begin
        if (too_cold) 
        begin
            heater = 1;
            aircon = 0;
        end
        else
        begin
            heater = 0;
            aircon = 0;
        end
    end
    else // cooling mode
    begin
        if (too_hot) 
        begin
            heater = 0;
            aircon = 1;
        end
        else
        begin
            heater = 0;
            aircon = 0;
        end
    end
end

endmodule
