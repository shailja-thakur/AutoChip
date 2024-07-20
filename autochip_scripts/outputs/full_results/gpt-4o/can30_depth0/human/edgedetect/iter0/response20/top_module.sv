module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] in_d; // Register to hold the delayed version of 'in'

    always @(posedge clk) begin
        in_d <= in; // Capture the input at each clock cycle
    end

    always @(posedge clk) begin
        pedge <= (~in_d & in); // Positive edge detection
    end

endmodule
