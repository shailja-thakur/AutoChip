module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b10000;
    end
    else begin
        q[4:1] <= q[3:0];
        q[0] <= q[4] ^ q[2];
    end
end

endmodule
