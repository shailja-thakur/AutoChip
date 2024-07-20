module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
reg q; // flip-flop output
reg state; // state variable

always @(posedge clk) begin
    if (a & !b)
        q <= 1'b0; // reset q to 0
    else if (!a & b)
        q <= 1'b1; // set q to 1
        
    state <= q;
end

assign q = state;

endmodule
