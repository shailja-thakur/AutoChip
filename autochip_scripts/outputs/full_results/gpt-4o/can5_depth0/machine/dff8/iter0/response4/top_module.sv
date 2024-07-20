module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

    // Initialize the output register to a default value
    initial begin
        q = 8'h0;
    end

    // Always block triggered on the rising edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
