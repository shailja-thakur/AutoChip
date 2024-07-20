module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

// Define a 4-bit register
reg [3:0] sr;

// Synchronize the register update with the clock signal
always @(posedge clk)
begin
    // Reset the register to all zeros when resetn signal is low
    if (~resetn)
        sr <= 4'b0000;
    // Shift the register left by one bit and load the input into the least significant bit when resetn signal is high
    else
        sr <= {sr[2:0], in};
end

// Output the most significant bit of the register
assign out = sr[3];

endmodule
