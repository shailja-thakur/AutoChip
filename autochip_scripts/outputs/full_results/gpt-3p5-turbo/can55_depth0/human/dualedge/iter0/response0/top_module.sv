module top_module(
    input clk,
    input d,
    output reg q);

reg dff_1;
reg dff_2;

always @(posedge clk) begin
    dff_1 <= d;
end

always @(negedge clk) begin
    dff_2 <= dff_1;
end

always @(posedge clk or negedge clk) begin
    q <= dff_2;
end

endmodule
