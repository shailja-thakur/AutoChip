module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

    // Initialize the output to a default value of 0
    initial begin
        q = 8'h0;
    end
    
    // On the rising edge of the clock, store the data input in the register
    always @(posedge clk) begin
        q <= d;
    end

endmodule
