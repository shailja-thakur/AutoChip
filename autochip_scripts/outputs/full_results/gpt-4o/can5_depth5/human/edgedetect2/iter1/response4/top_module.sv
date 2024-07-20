module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] prev_in;
    reg [7:0] edge_detected;

    always @(posedge clk) begin
        prev_in <= in;
        edge_detected <= in & ~prev_in;
        anyedge <= edge_detected;
    end

endmodule
