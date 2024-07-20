module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;                 // Store the input of the current cycle
        anyedge <= (~prev_in & in);    // Detect a rising edge
    end

endmodule
