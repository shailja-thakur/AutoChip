module top_module (
	input [4:1] x,
	output logic f
);

    always_comb begin
        case (x)
            // 00
            4'b0000: f = 1;
            // 01
            4'b0001: f = 0;
            // 11
            4'b0011: f = 1;
            // 10
            4'b0010: f = 1;
            // default
            default: f = 0;
        endcase
    end

endmodule
