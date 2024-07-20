module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

	always @(*) begin
		case(in)
            4'b0001: pos = 2'b0;
            4'b0010: pos = 2'b1;
            4'b0100: pos = 2'b2;
            4'b1000: pos = 2'b3;
            default: pos = 2'b0;
        endcase
    end
endmodule
