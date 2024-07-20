module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
    if (a) // If 'a' is 1, reset the state and output
        state <= 0;
    else if (b) // If 'b' is 1, toggle the state
        state <= ~state;
    q <= state; // Output follows the state
end

endmodule
