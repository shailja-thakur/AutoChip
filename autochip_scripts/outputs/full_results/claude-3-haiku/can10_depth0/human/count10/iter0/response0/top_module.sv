module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        q <= (q == 4'd9) ? 0 : q + 1;
    end
end

endmodule
