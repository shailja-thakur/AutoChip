module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b0?00: f=1'b0;
        4'b0?01: f=1'bx;
        4'b0?11: f=1'bx;
        4'b0?10: f=1'bx;
        4'b1?00: f=1'bx;
        4'b1?01: f=1'b0;
        4'b1?11: f=1'b1;
        4'b1?10: f=1'b0;
        default: f=1'bx;
    endcase
end

endmodule
