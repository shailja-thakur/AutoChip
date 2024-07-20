module top_module (
	input [31:0] in,
	output [31:0] out
);

	reg [31:0] reversed;

	always @(*) begin
		case (1'b1)
			in: begin
				reversed[31:24] = in[7:0];
				reversed[23:16] = in[15:8];
				reversed[15:8] = in[23:16];
				reversed[7:0] = in[31:24];
			end
			default: begin
				reversed = 32'b0;
			end
		endcase
	end

	assign out = reversed;
	
endmodule
