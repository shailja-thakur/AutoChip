module top_module (
    input [4:1] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0000, 4'b0010, 4'b0011, 4'b0100, 4'b0111: f = 0;
            4'b0110, 4'b1000, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101: f = 1;
            default: f = 1'bx;  // Don't-care or undefined cases
        endcase
    end

endmodule
