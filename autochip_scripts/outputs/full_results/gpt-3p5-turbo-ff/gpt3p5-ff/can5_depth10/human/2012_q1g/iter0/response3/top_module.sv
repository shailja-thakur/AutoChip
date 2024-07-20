module top_module (
	input [1:0] x,
	output logic f
);

    reg f;

    always_comb begin
        case (x)
            2'b00: f = 1;
            2'b01: f = 0;
            2'b10: f = 1;
            2'b11: f = 0;
            default: f = 0;
        endcase
    end

endmodule
