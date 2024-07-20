module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, 4'b0011, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001: f = 1'b0; // 0 values
            4'b0100, 4'b0111, 4'b1100, 4'b1101, 4'b1111: f = 1'b1; // 1 values
            default: f = 1'b1; // d values
        endcase
    end

endmodule
