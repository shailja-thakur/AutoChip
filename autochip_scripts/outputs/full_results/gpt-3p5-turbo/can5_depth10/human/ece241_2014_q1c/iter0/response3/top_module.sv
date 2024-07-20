module top_module (
    input signed [7:0] a,
    input signed [7:0] b,
    output reg signed [7:0] s,
    output reg overflow
);
    always @* begin
        s = a + b;
        if (s > 127 || s < -128) // check for overflow
            overflow = 1;
        else
            overflow = 0;
    end
endmodule
