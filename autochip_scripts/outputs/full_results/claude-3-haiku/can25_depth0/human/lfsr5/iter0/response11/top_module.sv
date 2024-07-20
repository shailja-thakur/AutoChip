module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 5'd1; // Reset to 1
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = {q[3:0], q[4] ^ q[2]};
end

endmodule
