module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

always @(*) begin
    if ((a[7] == 1 && b[7] == 1 && s[7] == 0) || (a[7] == 0 && b[7] == 0 && s[7] == 1)) begin
        overflow = 1;
    end else begin
        overflow = 0;
    end
    s = a + b;
end

endmodule
