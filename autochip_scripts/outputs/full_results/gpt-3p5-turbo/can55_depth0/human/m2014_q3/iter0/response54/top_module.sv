module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00xx: f = 1;   // Output 1 for the inputs 00xx
        4'b0100: f = 0;   // Output 0 for the input 0100
        4'b0110: f = 1;   // Output 1 for the input 0110
        4'b0111: f = 0;   // Output 0 for the input 0111
        4'b1001: f = 1;   // Output 1 for the input 1001
        4'b1010: f = 1;   // Output 1 for the input 1010
        4'b1011: f = 0;   // Output 0 for the input 1011
        4'b11xx: f = 1;   // Output 1 for the inputs 11xx
        default: f = 0;   // Output 0 for any other inputs
    endcase
end

endmodule
