module top_module (
    input [4:1] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0001: f = 1'b0;
            4'b0011: f = 1'b0;
            4'b0100: f = 1'b0;
            4'b0110: f = 1'b0;
            4'b1000: f = 1'b1;
            4'b1001: f = 1'b1;
            4'b1011: f = 1'b0;
            4'b1100: f = 1'b1;
            4'b1101: f = 1'b1;
            4'b1111: f = 1'b1;
            // Handle don't cares by assigning them convenient values
            default: f = 1'b0;
        endcase
    end
endmodule
