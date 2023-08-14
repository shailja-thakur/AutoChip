// Build a 100-bit left/right rotator, with synchronous load and left/right enable. A rotator shifts-in the shifted-out bit from the other end of the register, unlike a shifter that discards the shifted-out bit and shifts in a zero. If enabled, a rotator rotates the bits around and does not modify/discard them.

// load: Loads shift register with data[99:0] instead of rotating.
// ena[1:0]: Chooses whether and which direction to rotate.
// 2'b01 rotates right by one bit
// 2'b10 rotates left by one bit
// 2'b00 and 2'b11 do not rotate.
// q: The contents of the rotator.

module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    // Insert your code here

endmodule