module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] sum;
reg overflow;

always @(*) begin
    sum = a + b;
    
    if (sum[8] == 1 || sum[7] != sum[8])
        overflow = 1;
    else
        overflow = 0;
        
    s = sum[7:0];
end

endmodule
