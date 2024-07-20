module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] out_reg;

	always @(posedge clk) begin
		case (sel)
			0: out_reg <= in[3:0];
			1: out_reg <= in[7:4];
			2: out_reg <= in[11:8];
			3: out_reg <= in[15:12];
			4: out_reg <= in[19:16];
			5: out_reg <= in[23:20];
			6: out_reg <= in[27:24];
			7: out_reg <= in[31:28];
			default: out_reg <= 4'b0;
		endcase
	end
	
	assign out = out_reg;

endmodule
