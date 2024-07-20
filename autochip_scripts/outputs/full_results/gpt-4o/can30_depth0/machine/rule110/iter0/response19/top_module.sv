module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

	reg [511:0] temp_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			temp_q[511] = q[511];
            temp_q[510:0] = {q[509:0], 1'b0};
			q <= ~( 
				(q[511:1] & q[511:0] & temp_q) | 
				(~q[511:1] & ~q[511:0] & ~temp_q) | 
				(q[511:1] & ~q[511:0] & ~temp_q)
			);
		end
	end
endmodule
