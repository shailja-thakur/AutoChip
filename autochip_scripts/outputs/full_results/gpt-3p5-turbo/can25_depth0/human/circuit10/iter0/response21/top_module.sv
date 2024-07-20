module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

// Flip-flop definition
always @(posedge clk)
begin
    if (state)
        q <= a;
    else if (!state)
        q <= b;
end

// State transition logic
always @(posedge clk)
begin
    if (state)
        state <= !a & !b;
    else if (!state)
        state <= a;
end

endmodule
