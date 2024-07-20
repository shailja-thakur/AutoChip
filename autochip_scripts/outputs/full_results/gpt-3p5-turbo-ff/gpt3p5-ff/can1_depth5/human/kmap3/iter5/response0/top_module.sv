module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case({c, d, a, b})
            4'b0000: out = 1'b1;
            4'b0001: out = 1'bx;  // Fix: Set output as don't care for 4'b0001 case
            4'b0010: out = 1'b1;
            4'b0011: out = 1'b1;
            4'b0100: out = 1'bx;  // Fix: Set output as don't care for 4'b0100 case
            4'b0101: out = 1'bx;  // Fix: Set output as don't care for 4'b0101 case
            4'b0110: out = 1'b1;
            4'b0111: out = 1'b1;
            4'b1000: out = 1'bx;  // Fix: Set output as don't care for 4'b1000 case
            4'b1001: out = 1'bx;  // Fix: Set output as don't care for 4'b1001 case
            4'b1010: out = 1'bx;  // Fix: Set output as don't care for 4'b1010 case
            4'b1011: out = 1'bx;  // Fix: Set output as don't care for 4'b1011 case
            4'b1100: out = 1'bx;  // Fix: Set output as don't care for 4'b1100 case
            4'b1101: out = 1'bx;  // Fix: Set output as don't care for 4'b1101 case
            4'b1110: out = 1'bx;  // Fix: Set output as don't care for 4'b1110 case
            4'b1111: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
