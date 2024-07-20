module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    wire [7:0] sum;
    assign sum = a + b;
    
    always @(sum) begin
        s = sum[7:0];
        if ((a[7] == b[7]) && (a[7] != s[7])) begin
            overflow = 1;
        end else begin
            overflow = 0;
        end
    end
    
endmodule
