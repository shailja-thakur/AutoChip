module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
    // Wire to keep track of whether the phone should ring or vibrate
    wire should_ring;
    
    // Assign the should_ring signal based on the vibrate_mode input
    assign should_ring = ~vibrate_mode;
    
    // Use should_ring signal to control the ringer and motor outputs
    assign ringer = ring & should_ring;
    assign motor = ring & ~should_ring;
endmodule
