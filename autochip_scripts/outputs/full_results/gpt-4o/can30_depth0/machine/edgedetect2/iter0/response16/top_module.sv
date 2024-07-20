module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    // Register to store the previous value of the input signal
    reg [7:0] d_last;

    always @(posedge clk) begin
        // Update the previous value with the current value
        d_last <= in;
        // Calculate the anyedge signal using XOR operation
        anyedge <= in ^ d_last;
    end

endmodule
