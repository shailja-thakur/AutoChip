module top_module(
	input wire ring, 
	input wire vibrate_mode,
	output reg ringer,
	output reg motor
);

  // Assign statements for controlling ringer and motor outputs
  assign ringer = ring & ~vibrate_mode;
  assign motor = ring & vibrate_mode;

endmodule
