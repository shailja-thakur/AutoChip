module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        // x[3]x[4]   00 01 11 10
        //  00 | d | 0 | d | d |
        //  01 | 0 | d | 1 | 0 |
        //  11 | 1 | 1 | d | d |
        //  10 | 1 | 1 | 0 | d |
        4'b0000, 4'b0101, 4'b1101: f = 0;
        4'b0100, 4'b1011: f = 1;
        default: f = 0; // For don't-care values
    endcase
end

endmodule
