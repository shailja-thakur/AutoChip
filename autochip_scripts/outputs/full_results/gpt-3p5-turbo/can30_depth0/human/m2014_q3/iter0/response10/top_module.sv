module top_module (
	input [4:1] x,
	output logic f
);
    always_comb begin
        case(x)
            4'b00__: f = d; // d is a don't-care value
            4'b010_: f = 0;
            4'b01_1: f = 1;
            4'b011_: f = 0;
            4'b110_: f = 1;
            default: f = d;
        endcase
    end
endmodule
