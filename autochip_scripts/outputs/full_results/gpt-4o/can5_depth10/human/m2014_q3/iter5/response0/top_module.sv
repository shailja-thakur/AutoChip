module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, 4'b0011, 4'b0110: f = 1'b0; // 0 values
            4'b0111, 4'b1100, 4'b1101: f = 1'b1; // 1 values
            default: f = 1'b0; // Adjust d values as needed
        endcase
    end

endmodule
