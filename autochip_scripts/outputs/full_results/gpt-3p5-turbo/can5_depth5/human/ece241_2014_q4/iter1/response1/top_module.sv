module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
reg d1_next, d2_next, d3_next;

always @(posedge clk) begin
    d1 <= d1_next;
    d2 <= d2_next;
    d3 <= d3_next;
end

always @* begin
    d1_next = x ^ d1;
    d2_next = ~(d2 & d1);
    d3_next = ~(d3 | d1);
    z = ~(d1 & ~d2 & ~d3);
end

initial begin
    d1 = 1'b0;
    d2 = 1'b0;
    d3 = 1'b0;
end

endmodule
