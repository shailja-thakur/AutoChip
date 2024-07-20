module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Declare internal signals
reg ringer_internal;
reg motor_internal;

// Logic for controlling ringer and motor
always @(*) begin
    if (vibrate_mode == 1) begin
        ringer_internal = 0;
        motor_internal = 1;
    end
    else begin
        ringer_internal = 1;
        motor_internal = 0;
    end
end

// Assign internal signals to outputs
assign ringer = ringer_internal;
assign motor = motor_internal;

endmodule
