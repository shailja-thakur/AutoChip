module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({c, d, a, b}) // Combine inputs into a 4-bit vector for simplicity
            4'b0001: out = 0; // when c=0, d=0, a=0, b=1
            4'b0010: out = 1; // when c=0, d=0, a=1, b=0
            4'b0011: out = 1; // when c=0, d=0, a=1, b=1
            4'b0100: out = 0; // when c=0, d=1, a=0, b=0
            // 4'b0101: don't care
            4'b0110: out = 1; // when c=0, d=1, a=1, b=0
            // 4'b0111: don't care
            4'b1000: out = 0; // when c=1, d=0, a=0, b=0
            4'b1001: out = 0; // when c=1, d=0, a=0, b=1
            4'b1010: out = 0; // when c=1, d=1, a=1, b=0
            4'b1011: out = 0; // when c=1, d=1, a=1, b=1
            4'b1100: out = 1; // when c=1, d=0, a=0, b=0
            4'b1101: out = 0; // when c=1, d=0, a=1, b=0
            4'b1110: out = 1; // when c=1, d=1, a=0, b=0
            4'b1111: out = 1; // when c=1, d=1, a=1, b=1
            default: out = 0; // Default case
        endcase
    end

endmodule
