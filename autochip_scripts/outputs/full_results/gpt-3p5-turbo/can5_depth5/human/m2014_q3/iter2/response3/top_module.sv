module top_module (
    input [4:1] x,
    output logic f
);


always_comb begin
    case (x)
        // x[3]x[4]   00 01 11 10
        4'b00?0, 4'b00?1, 4'b01?0, 4'b01?1, 4'b10?0, 4'b11?0: f = 0;
        4'b0001, 4'b0011, 4'b0110, 4'b1011: f = 1;
        default: f = 1; // For don't-care values
    endcase
end


endmodule
