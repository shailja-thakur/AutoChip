module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'b00000, 5'b00001, 5'b00100, 5'b00101, 5'b00110, 5'b01110, 5'b01111: begin
            f = 1'b1;
        end
        5'b00010, 5'b00011, 5'b00111, 5'b01000, 5'b01001, 5'b01010, 5'b01011, 5'b01101: begin
            f = 1'b0;
        end
        default: begin
            f = 1'b0;
        end
    endcase
end

endmodule
