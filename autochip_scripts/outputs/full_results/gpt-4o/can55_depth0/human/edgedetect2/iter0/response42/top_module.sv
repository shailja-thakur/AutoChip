module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] in_d; // to store delayed version of in

    always @(posedge clk) begin
        in_d <= in; // capture the current state of 'in' on the clock's rising edge
        anyedge <= in & ~in_d; // detect rising edges for each bit
    end

endmodule
