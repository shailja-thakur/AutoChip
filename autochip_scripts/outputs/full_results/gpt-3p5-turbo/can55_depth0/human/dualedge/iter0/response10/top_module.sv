module top_module (
    input wire clk,
    input wire d,
    output reg q
);

reg q2;

always @(posedge clk) begin
    q2 <= d;
end

always @(negedge clk) begin
    q <= q2;
end

endmodule
