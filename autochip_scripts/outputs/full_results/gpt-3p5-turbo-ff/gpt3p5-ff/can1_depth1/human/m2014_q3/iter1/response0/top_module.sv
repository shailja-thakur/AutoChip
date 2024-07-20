module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case(x)
        4'b0000: f = 1'b1;
        4'b0001: f = 1'b0;
        4'b0010: f = 1'b0;
        4'b0011: f = 1'b1;
        4'b0100: f = 1'b0;
        4'b0110: f = x[1];
        4'b1000: f = 1'b1;
        4'b1011: f = 1'b1;
        4'b1010: f = 1'b0;
        default: f = 1'bx; // don't care case
    endcase
end

endmodule
