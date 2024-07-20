module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] out_reg; // Register to store the output
	
	always @ (in or sel) begin
		case(sel)
			4'b0000: out_reg <= in[3:0];
			4'b0001: out_reg <= in[7:4];
			4'b0010: out_reg <= in[11:8];
			// Add more cases for the other possible values of sel
			default: out_reg <= 4'b0000; // Default case - Assign all zeros
		endcase
	end

	assign out = out_reg;
	
endmodule
