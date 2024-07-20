module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    reg [31:0] sum;
    reg cout;
    
    always @ (a or b)
    begin
        sum <= a + b;
        cout <= (a[31] & b[31]) | (sum[31] & (a[31] | b[31]));
    end
    
    assign sum = sum;
    assign cout = cout;
endmodule
