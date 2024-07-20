module top_module (
	input wire clk,
	input wire enable,
	input wire S,
	input wire [2:0] addr,
	input wire [7:0] data_in,
	output reg [7:0] data_out
);

	reg [7:0] q;

	always @(posedge clk) begin
		if (enable) begin
			q <= {q[6:0], S};
		end
	end

	always @(addr) begin
		case (addr)
			3'b000: data_out <= q[0];
			3'b001: data_out <= q[1];
			3'b010: data_out <= q[2];
			3'b011: data_out <= q[3];
			3'b100: data_out <= q[4];
			3'b101: data_out <= q[5];
			3'b110: data_out <= q[6];
			3'b111: data_out <= q[7];
			default: data_out <= 8'b0;
		endcase
	end
endmodule
