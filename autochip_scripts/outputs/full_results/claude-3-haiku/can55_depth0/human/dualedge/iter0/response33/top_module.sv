module top_module(
    input clk,
    input d,
    output reg q
);

reg clk_delayed;

always @(posedge clk) begin
    clk_delayed <= clk;
end

always @(posedge clk, posedge clk_delayed) begin
    if (clk_delayed) begin
        q <= d;
    end
end

endmodule
