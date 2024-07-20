module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, 4'b0100, 4'b1110: f = 1'b0; // 0 values
            4'b0011, 4'b0111, 4'b1000, 4'b1001, 4'b1011, 4'b1100: f = 1'b1; // 1 values
            default: f = 1'b1; // Use 1 for d values, can change if necessary for different optimization
        endcase
    end

endmodule
