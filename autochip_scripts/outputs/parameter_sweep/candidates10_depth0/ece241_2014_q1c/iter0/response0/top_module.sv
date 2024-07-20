module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] sum;
    wire signed_overflow;
    
    assign s = sum;
    assign overflow = signed_overflow;
    
    always @(a or b) begin
        sum = a + b;
        signed_overflow = (a[7] == b[7]) && (a[7] != sum[7]);
    end
    
endmodule
