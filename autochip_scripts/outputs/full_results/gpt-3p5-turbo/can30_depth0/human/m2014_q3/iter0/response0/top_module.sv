module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b00x0: f = 1'b1; // x[3]=0, x[2]=don't care, x[1]=0
        4'b01x1: f = 1'b1; // x[3]=0, x[2]=don't care, x[1]=1
        4'b11x0: f = 1'b1; // x[3]=1, x[2]=don't care, x[1]=0
        4'b11x1: f = 1'b1; // x[3]=1, x[2]=don't care, x[1]=1
        4'b1x00: f = 1'b1; // x[3]=don't care, x[2]=1, x[1]=0
        4'b1x01: f = 1'b0; // x[3]=don't care, x[2]=1, x[1]=1
        4'b1x11: f = 1'b0; // x[3]=don't care, x[2]=1, x[1]=1
        4'b10x10: f = 1'b0; // x[3]=don't care, x[2]=1, x[1]=0
        default: f = 1'b0; // Any other combination
    endcase
end

endmodule
