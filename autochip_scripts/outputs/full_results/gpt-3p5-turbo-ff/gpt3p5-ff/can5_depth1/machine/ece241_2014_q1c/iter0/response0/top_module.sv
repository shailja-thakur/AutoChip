module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    wire [8:0] sum;
    
    assign sum = a + b;
    assign s = sum[7:0];
    
    always @(sum, a, b) begin
        if ((a[7] == b[7]) && (sum[8] != a[7]))
            overflow = 1;
        else
            overflow = 0;
    end

endmodule
