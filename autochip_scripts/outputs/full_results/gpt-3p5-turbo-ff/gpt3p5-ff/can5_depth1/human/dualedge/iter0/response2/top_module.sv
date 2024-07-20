module top_module(
        input clk,
        input d,
        output reg q);

reg q1, q2;
assign q = q2;

always @(posedge clk) begin
    q1 <= d;
end

always @(negedge clk) begin
    q2 <= q1;
end

endmodule
