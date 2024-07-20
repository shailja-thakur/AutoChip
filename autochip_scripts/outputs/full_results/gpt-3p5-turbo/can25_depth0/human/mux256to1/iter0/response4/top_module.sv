module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

reg out;

always @(*) begin
    case(sel)
        8'h00: out = in[0];
        8'h01: out = in[1];
        8'h02: out = in[2];
        8'h03: out = in[3];
        8'h04: out = in[4];
        8'h05: out = in[5];
        8'h06: out = in[6];
        8'h07: out = in[7];
        // continue with all 256 cases
    endcase
end

endmodule
