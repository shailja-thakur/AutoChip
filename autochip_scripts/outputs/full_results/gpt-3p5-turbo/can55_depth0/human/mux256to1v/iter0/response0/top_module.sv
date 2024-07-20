module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] expanded_in [0:3];

generate
	for (genvar i = 0; i < 4; i++) begin: expand_in
		always @(in) begin
			expanded_in[i] = in[1023:((i+1)*256)] >> (i*256);
		end
	end
endgenerate

always @(sel or expanded_in) begin
	case(sel)
		4'b0000: out = expanded_in[0];
		4'b0001: out = expanded_in[1];
		4'b0010: out = expanded_in[2];
		4'b0011: out = expanded_in[3];
		default: out = 4'b0; // Default case when sel is not in the range 0 to 3
	endcase
end

endmodule
