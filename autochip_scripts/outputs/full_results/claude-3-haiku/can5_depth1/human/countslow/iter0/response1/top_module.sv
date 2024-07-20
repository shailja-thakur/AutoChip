module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;
    end
    else if (slowena) begin
        q <= (q == 4'b1001) ? 4'b0000 : q + 1;
    end
end

endmodule
