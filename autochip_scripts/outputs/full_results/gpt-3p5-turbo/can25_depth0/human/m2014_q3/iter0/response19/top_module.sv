module top_module (
	input [4:1] x,
	output logic f
);

    always_comb begin
        case (x)
            4'b00xx: f = 0; // don't care
            4'b0100: f = 0;
            4'b0110: f = 1;
            4'b110x: f = 1; // don't care
            default: f = 0; // default value for any other input combination
        endcase
    end

endmodule
