module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        // row 0
        4'b0000:
            f = x[1];    // output d
        4'b0001:
            f = 1'b0;
        4'b0010:
            f = x[2];    // output d
        4'b0011:
            f = 1'b0;
            
        // row 1
        4'b0100:
            f = 1'b0;
        4'b0101:
            f = x[2];
        4'b0110:
            f = 1'b1;
        4'b0111:
            f = 1'b0;
            
        // row 2
        4'b1000:
            f = 1'b1;
        4'b1001:
            f = 1'b1;
            
        // row 3
        4'b1100:
            f = 1'b0;
        4'b1101:
            f = 1'b1;
        4'b1110:
            f = 1'b0;
    endcase
end

endmodule
