module top_module (
	input [4:1] x,
	output logic f
);

    always_comb begin
        f = (x == 4'b0000) ||
            (x == 4'b0011) ||
            (x == 4'b1000) ||
            (x == 4'b1001) ||
            (x == 4'b1010) ||
            (x == 4'b1011) ||
            (x == 4'b1100) ||
            (x == 4'b1101) ||
            (x == 4'b1110);
    end

endmodule
