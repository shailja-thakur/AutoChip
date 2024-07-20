module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Signal for overflow detection
    reg overflow;

    // 2's complement addition
    assign s = a + b;

    // Overflow detection logic
    always @* begin
        if (((a[7] & b[7]) & ~s[7]) | ((~a[7] & ~b[7]) & s[7]))
            overflow = 1;
        else
            overflow = 0;
    end
    
endmodule
