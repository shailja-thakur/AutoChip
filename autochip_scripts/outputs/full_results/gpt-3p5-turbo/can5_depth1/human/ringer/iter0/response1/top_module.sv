module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
    // Logic to control the ringer and motor based on phone mode
    assign ringer = vibrate_mode ? 0 : ring;
    assign motor = vibrate_mode ? ring : 0;
endmodule
