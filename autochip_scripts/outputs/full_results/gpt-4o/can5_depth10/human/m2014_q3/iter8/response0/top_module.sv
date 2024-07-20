module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, // 01
            4'b0100, 4'b0101, // 10, 11
            4'b0110: f = 1'b0; // 01
            4'b1110, // 11
            4'b1111, // 11
            4'b1011, // 01
            4'b1100, 4'b1101, // 01, 10
            4'b1000, 4'b1001: f = 1'b1; // 10, 11
            4'b0010, 4'b0111: f = 1'b1; // 01
            default: f = 1'b0;
        endcase
    end

endmodule
