module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    reg overflow;
    
    assign sum = a + b;
    assign s = sum[7:0];
    
    always @(*) begin
        if (sum[8])
            overflow = 1;
        else
            overflow = 0;
    end
    
endmodule
