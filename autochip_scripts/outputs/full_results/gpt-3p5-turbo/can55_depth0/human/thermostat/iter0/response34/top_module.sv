module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Define internal signal for fan operation
reg fan_operate;

// Assign fan output to internal signal
assign fan = fan_operate || fan_on;

// Case statement to determine operating conditions
always @(*) begin
    case(mode)
        1: begin
                heater = too_cold;
                aircon = 0;
                fan_operate = heater || aircon || fan_on;
           end
        0: begin
                heater = 0;
                aircon = too_hot;
                fan_operate = heater || aircon || fan_on;
           end
    endcase
end

endmodule
