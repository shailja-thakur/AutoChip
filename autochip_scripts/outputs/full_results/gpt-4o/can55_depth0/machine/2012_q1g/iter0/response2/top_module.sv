module top_module (
	input [4:0] x,
	output logic f
);

always_comb begin
    case(x)
        5'h0: f = 1;
        5'h1: f = 1;
        5'h2: f = 0;
        5'h3: f = 0;
        5'h4: f = 1;
        5'h5: f = 1;
        5'h6: f = 1;
        5'h7: f = 0;
        5'h8: f = 0;
        5'h9: f = 0;
        5'ha: f = 0;
        5'hb: f = 0;
        5'hc: f = 1;
        5'hd: f = 0;
        5'he: f = 1;
        5'hf: f = 1;
        default: f = 0; // Default case to avoid latches
    endcase
end

endmodule
