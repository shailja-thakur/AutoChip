module top_module (
	input [4:1] x,
	output logic f
);

    always_comb begin
        f = 0;  // default output
        case (x)
            4'b0000: f = 1;
            4'b0011: f = 1;
            4'b1000: f = 1;
            4'b1001: f = 1;
            4'b1010: f = 1;
            4'b1100: f = 1;
            4'b1101: f = 1;
            4'b1110: f = 1;
            4'b1011: f = 1;
        endcase
    end

endmodule
