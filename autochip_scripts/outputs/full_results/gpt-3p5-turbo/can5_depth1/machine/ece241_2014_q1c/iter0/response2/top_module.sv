module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

// create an 8-bit wire sum which is the sum of the two inputs a and b
wire [7:0] sum;
assign sum = a + b;

// assign the 8-bit output s to the 8 least significant bits of the sum
assign s = sum[7:0];

// assign the overflow output to a logical expression
always @(a, b) begin
    if (a[7] == b[7] && s[7] != a[7]) begin
        overflow = 1;
    end else begin
        overflow = 0;
    end
end

endmodule
