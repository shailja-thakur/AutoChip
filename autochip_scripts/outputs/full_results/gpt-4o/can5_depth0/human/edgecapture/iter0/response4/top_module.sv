module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

    reg [31:0] previous_in;
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'd0;
            previous_in <= 32'd0;
        end else begin
            out <= out | (previous_in & ~in);
            previous_in <= in;
        end
    end
endmodule
