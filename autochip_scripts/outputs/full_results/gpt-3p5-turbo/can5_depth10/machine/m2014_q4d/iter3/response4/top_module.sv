module top_module (
	input clk,
	input in,
    input reset,
	output reg out
);

	always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else 
            out <= in ^ out;
	end

endmodule
