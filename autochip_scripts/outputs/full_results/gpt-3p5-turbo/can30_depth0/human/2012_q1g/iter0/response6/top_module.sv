module top_module (
	input [4:1] x,
	output logic f
);
    always_comb begin
        case(x)
            4'b00?? : f = 1; // Case when x[3:2] = 00
            4'b01?? : f = 0; // Case when x[3:2] = 01
            4'b11?? : f = 1; // Case when x[3:2] = 11
            4'b10?? : f = 1; // Case when x[3:2] = 10
            default : f = 0; // All other cases
        endcase
    end
endmodule
