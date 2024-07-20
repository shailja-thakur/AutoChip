module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    always @(posedge clk) begin
    	if (reset)
        	q <= 0;
        else
        	q <= d;
    end

endmodule
