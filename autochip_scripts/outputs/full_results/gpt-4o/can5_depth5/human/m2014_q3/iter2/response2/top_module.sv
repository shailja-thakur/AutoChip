module top_module (
    input [4:1] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0000: f = 1'b0;  // d but choose to output 0
            4'b0001: f = 1'b0;
            4'b0010: f = 1'b0;  // d but choose to output 0
            4'b0011: f = 1'b0;  // d but choose to output 0
            4'b0100: f = 1'b0;
            4'b0101: f = 1'b0;  // d but choose to output 0
            4'b0110: f = 1'b1;
            4'b0111: f = 1'b0;
            4'b1000: f = 1'b1;
            4'b1001: f = 1'b1;
            4'b1010: f = 1'b1;  // Corrected as per K-map (was 0 before)
            4'b1011: f = 1'b0;  // Corrected as per K-map (was 1 before)
            4'b1100: f = 1'b1;
            4'b1101: f = 1'b1;
            4'b1110: f = 1'b0;  // Corrected as per K-map (was 1 before)
            4'b1111: f = 1'b0;  // Corrected as per K-map (was 1 before)
            default: f = 1'b0;
        endcase
    end

endmodule
