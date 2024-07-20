module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg state, next_state;

parameter A = 1'b0;
parameter B = 1'b1;

always @(posedge clk or posedge reset)
    if (reset)
        state <= A;
    else
        state <= next_state;

always @*
    if (state == A)
        if (j)
            next_state = B;
        else
            next_state = A;
    else
        if (k)
            next_state = A;
        else
            next_state = B;

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
