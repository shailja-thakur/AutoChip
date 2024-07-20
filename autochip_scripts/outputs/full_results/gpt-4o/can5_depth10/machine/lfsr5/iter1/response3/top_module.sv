module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

reg [4:0] q_next;

always @(*) begin
    q_next = {q[3:0], q[0]};    // shift q left and bring LSB to MSB
    q_next[2] = q_next[2] ^ q[0]; // xor bit 2 with q[0]
end

always @(posedge clk) begin
    if (reset) begin
        q <= 5'h1; // reset value
    end else begin
        q <= q_next; // state transition
    end
end

endmodule
