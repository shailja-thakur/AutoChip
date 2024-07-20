module top_module (
	input [4:1] x,
	output logic f
);
    logic x1, x2, x3, x4;

    assign x1 = x[1];
    assign x2 = x[2];
    assign x3 = x[3];
    assign x4 = x[4];

    always_comb begin
        case ({x3, x4})
            2'b00: f = x1 & x2;
            2'b01: f = 1'b0;
            2'b10: f = x1 | x2;
            2'b11: f = ~(x1 & x2);
        endcase
    end
endmodule
