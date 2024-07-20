module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    wire carry;
    
    assign carry = sum[8];
    assign s = sum[7:0];
    
    always @(*) begin
        sum = a + b;
        if (a[7] == b[7] && sum[7] != a[7])
            overflow = 1;
        else
            overflow = 0;
    end
    
endmodule
