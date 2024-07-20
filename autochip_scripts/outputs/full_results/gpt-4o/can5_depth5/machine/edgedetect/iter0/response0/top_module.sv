module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] d_last; // register to store the previous value of the input signal

    // Always triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        d_last <= in; // store the current value of the input signal
        pedge <= in & ~d_last; // calculate the rising edge detection signal
    end

endmodule
