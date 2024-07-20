module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001: f = 0;
            4'b0011: f = 1;
            4'b0110: f = 0;
            4'b0111: f = 1;
            4'b1000: f = 1;
            4'b1001: f = 1;
            4'b1010: f = 0;
            4'b1100: f = 1;
            4'b1101: f = 1;
            default: f = 0; // Handling don't-care terms
        endcase
    end

endmodule
