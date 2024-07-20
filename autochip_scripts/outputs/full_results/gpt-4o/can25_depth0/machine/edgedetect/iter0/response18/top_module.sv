module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] d_last; // Register to store value of the input signal from the previous clock cycle

    always @(posedge clk) begin
        d_last <= in; // Store the current input value to d_last for the next clock cycle
        pedge <= in & ~d_last; // Calculate the rising edges
    end

endmodule
