module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

	reg [3:0] q_temp;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 4'b0;
		end else begin
			if (load) begin
				q <= data;
			end else if (ena) begin
				q_temp[3] <= 1'b0;
				q_temp[2:0] <= q[3:1];
				q <= q_temp;
			end
		end
	end
endmodule
