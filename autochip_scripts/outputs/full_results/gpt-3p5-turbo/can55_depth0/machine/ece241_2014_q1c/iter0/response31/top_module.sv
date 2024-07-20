module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    wire [7:0] sum;
    
    always @(a, b)
    begin
        sum = a + b;
        s = sum[7:0];
        
        if ((a[7] == b[7]) && (sum[7] != a[7]))
            overflow = 1;
        else
            overflow = 0;
    end
    
endmodule
