module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'b00000, 5'b00001, 5'b00100, 5'b00101, 5'b00110, 5'b01110, 5'b11111: f = 1;
        5'b00010, 5'b00011, 5'b00111, 5'b01000, 5'b01001, 5'b01010, 5'b01011, 5'b01101, 5'b01111: f = 0;
        default: f = 'X;
    endcase
end

endmodule
