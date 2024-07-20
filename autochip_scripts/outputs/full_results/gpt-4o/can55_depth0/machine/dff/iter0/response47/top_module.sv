module top_module(
	input clk,
	input d,
	output reg q);

    // Initial value of q is unknown
    initial begin
        q = 1'bx;
    end

    // On rising edge of clk, assign d to q
    always @(posedge clk) begin
        q <= d;
    end

endmodule
