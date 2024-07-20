module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
	
	reg [7:0] q_lower_byte;
	reg [7:0] q_upper_byte;

	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			q <= 16'd0;
		else begin
			if (byteena[0])
				q_lower_byte <= d[7:0];
			if (byteena[1])
				q_upper_byte <= d[15:8];
			q <= {q_upper_byte, q_lower_byte};
		end
	end
	
endmodule
