module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg[1:0] state;

always @(posedge clk) begin
    state[0] <= a & b; // combinational logic
    state[1] <= state[0]; // sequential logic (flip-flop)
    q <= state[1];
end

endmodule
