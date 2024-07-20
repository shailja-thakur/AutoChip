module top_module(
    input clk,
    input d,
    output reg q
);

reg d_sync1, d_sync2;

always @(posedge clk) begin
    d_sync1 <= d;
    d_sync2 <= d_sync1;
end

always @(posedge clk, negedge clk) begin
    if (clk) begin
        q <= d_sync2;
    end
end

endmodule
