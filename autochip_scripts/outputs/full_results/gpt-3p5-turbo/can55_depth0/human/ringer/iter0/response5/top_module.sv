module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Declare internal signals
reg activate_ringer;
reg activate_motor;

// Assign values to internal signals based on input conditions
always @(*)
begin
    if (vibrate_mode == 1'b1) begin
        activate_ringer = 1'b0;
        activate_motor = 1'b1;
    end
    else begin
        activate_ringer = 1'b1;
        activate_motor = 1'b0;
    end
end

// Assign internal signals to output ports
assign ringer = activate_ringer;
assign motor = activate_motor;

endmodule
