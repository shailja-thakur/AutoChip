module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q[4] = q[0] ^ q[2];
    next_q[3:1] = q[2:0];
    next_q[0] = q[4] ^ q[2];
end

endmodule
