module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, 4'b0010, 4'b0011, 4'b1001: f = 1'b0;
            4'b1100, 4'b1101, 4'b1011, 4'b0110, 4'b0111: f = 1'b1;
            default: f = 1'bx; // don't-care conditions, you could also assign these to 1 or 0 if desired
        endcase
    end

endmodule
