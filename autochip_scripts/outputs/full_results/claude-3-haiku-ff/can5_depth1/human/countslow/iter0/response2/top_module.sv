module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0;
    end
    else if (slowena) begin
        q <= (q == 4'd9) ? 4'b0 : q + 1'b1;
    end
end

endmodule
