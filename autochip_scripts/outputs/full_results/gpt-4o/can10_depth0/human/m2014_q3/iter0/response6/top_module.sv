module top_module (
    input [4:1] x,
    output logic f
);
    always_comb begin
        case (x)
            4'b0001, 4'b0010, 4'b0011, 4'b0110, 4'b0100, 4'b1011: f = 0; // Combine all cases where output is 0
            4'b0101, 4'b0111, 4'b1111, 4'b1110, 4'b1010: f = 1; // Combine all cases where output is 1
            default: f = 1'bx; // For don't-care conditions, can be set to 'x'
        endcase
    end
endmodule
