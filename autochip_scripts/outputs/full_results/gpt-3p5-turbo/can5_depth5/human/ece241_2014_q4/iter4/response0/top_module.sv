module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;

always @(posedge clk) begin
    d1 <= x ^ d1;
end

always @(posedge clk) begin
    d2 <= ~(d2 & d1);
end

always @(posedge clk) begin
    d3 <= ~(d3 | d1);
end

always @(posedge clk) begin
    z <= ~(d1 & d2 & d3);
end

initial begin
    d1 <= 1'b0;
    d2 <= 1'b0;
    d3 <= 1'b0;
end

endmodule
