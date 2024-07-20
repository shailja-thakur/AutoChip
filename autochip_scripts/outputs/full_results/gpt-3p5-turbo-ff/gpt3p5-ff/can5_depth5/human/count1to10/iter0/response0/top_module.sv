module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0001;
    end
    else begin
        q <= (q == 4'b1010) ? 4'b0001 : q + 1;
    end
end

endmodule
