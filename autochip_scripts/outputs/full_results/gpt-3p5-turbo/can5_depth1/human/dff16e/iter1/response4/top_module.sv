module top_module(
	input wire clk,
	input wire resetn,
	input wire [1:0] byteena,
	input wire [15:0] d,
	output reg [15:0] q
);

	reg [7:0] q_lower;
	reg [7:0] q_upper;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
		begin
			q_lower <= 8'b0;
			q_upper <= 8'b0;
		end
		else
		begin
			if (byteena[0])
			begin
				q_lower <= d[7:0];
			end
			if (byteena[1])
			begin
				q_upper <= d[15:8];
			end
		end
	end

	always @*
	begin
		q = {q_upper, q_lower};
	end
endmodule
