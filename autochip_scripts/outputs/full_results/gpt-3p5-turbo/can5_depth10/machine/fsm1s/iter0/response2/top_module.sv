module top_module (
	input clk,
	input in,
	input reset,
	output out
);
    reg state;
    always @(posedge clk) begin
        if (reset)
            state <= 0;
        else if (state == 0 && in)
            state <= 0;
        else if (state == 0 && !in)
            state <= 1;
        else if (state == 1 && in)
            state <= 1;
        else if (state == 1 && !in)
            state <= 0;
    end
    
    assign out = state;

endmodule
