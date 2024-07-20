module top_module(
    input wire ring,
    input wire vibrate_mode,
    output wire ringer,
    output wire motor
);

// Ringer is active when ring = 1 and vibrate_mode = 0
assign ringer = ring & ~vibrate_mode;

// Motor is active when ring = 1 and vibrate_mode = 1
assign motor = ring & vibrate_mode;

endmodule
