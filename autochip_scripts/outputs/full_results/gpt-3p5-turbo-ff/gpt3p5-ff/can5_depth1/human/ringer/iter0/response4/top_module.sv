module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Verilog code to control cellphone's ringer and vibration motor
// Whenever the phone needs to ring from an incoming call (input ring), the circuit will either turn on the ringer (output ringer = 1) or the motor (output motor = 1), but not both. If the phone is in vibrate mode (input vibrate_mode = 1), the motor will be turned on. Otherwise, the ringer will be turned on.

reg ringer;
reg motor;

always @(*) begin
	if (vibrate_mode == 1) begin
		ringer = 0;
		motor = 1;
	end else begin
		ringer = 1;
		motor = 0;
	end
end

endmodule
