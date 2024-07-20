module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    
    always @(*) begin
        {overflow, sum[7:0]} = a + b;
    end
    
    assign s = sum[7:0];
    
endmodule
