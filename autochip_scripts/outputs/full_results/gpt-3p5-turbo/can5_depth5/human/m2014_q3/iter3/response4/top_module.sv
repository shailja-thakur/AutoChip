module top_module (
    input [4:1] x,
    output logic f
);


always_comb begin
    case (x)
        // x[3]x[4]   00 01 11 10
        4'b0000, 4'b0100, 4'b0111: f = 0;
        4'b0001, 4'b0011, 4'b0110: f = 1;
        default: f = 1; // For don't-care values
    endcase
end


endmodule
