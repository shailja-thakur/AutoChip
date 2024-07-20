module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] prev_in;
    
    always @(posedge clk) begin
        prev_in <= in;
        anyedge <= (in ^ prev_in) & in; // Detect any edge and output 1 on 0 to 1 transition
    end

endmodule
