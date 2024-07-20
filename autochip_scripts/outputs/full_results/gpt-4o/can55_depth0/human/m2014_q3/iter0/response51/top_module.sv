module top_module (
    input [4:1] x,
    output logic f
);
    
    always_comb begin
        case (x)
            4'b0000: f = 1'b0;    // d can be 0 or 1, here chosen as 0
            4'b0001, 4'b0011, 
            4'b0111, 4'b1011, 
            4'b1100, 4'b1101  : f = 1'b0;    // specified 0 or convenient 0 chosen
            4'b0010: f = 1'b0;    // specified 0
            4'b0100: f = 1'b0;    // specified 0
            4'b0110: f = 1'b1;    // specified 1
            4'b1000: f = 1'b1;    // specified 1
            4'b1110: f = 1'b0;    // specified 0
            4'b1111: f = 1'b0;    // d can be 0 or 1, here chosen as 0
            default: f = 1'b1;    // remaining d states, chosen as convenient 1
        endcase
    end
endmodule
