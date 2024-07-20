module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case(x)
        5'b00000, 5'b00001, 5'b00010, 5'b00011, 5'b00100, 5'b00101, 5'b00110, 5'b00111, 5'b01100, 5'b01110, 5'b01111: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
