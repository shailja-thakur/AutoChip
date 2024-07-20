module top_module (
    input [4:0] x,
    output logic f
);
    
    always_comb begin
        case (x)
            5'b00000: f = 1'b1;
            5'b00001: f = 1'b1;
            5'b00010: f = 1'b0;
            5'b00011: f = 1'b0;
            5'b00100: f = 1'b1;
            5'b00101: f = 1'b1;
            5'b00110: f = 1'b1;
            5'b00111: f = 1'b0;
            5'b01000: f = 1'b0;
            5'b01001: f = 1'b0;
            5'b01010: f = 1'b0;
            5'b01011: f = 1'b0;
            5'b01100: f = 1'b1;
            5'b01101: f = 1'b0;
            5'b01110: f = 1'b1;
            5'b01111: f = 1'b1;
            default: f = 1'b0;
        endcase
    end

endmodule
