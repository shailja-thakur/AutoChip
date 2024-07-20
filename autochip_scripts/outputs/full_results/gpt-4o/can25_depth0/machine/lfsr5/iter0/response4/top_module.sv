module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] q_next;

always @(*) begin
    q_next = q[4:1]; // Assigning q_next with q[4:1]
    q_next[4] = q[0]; // LSB bit to MSB bit
    q_next[2] = q_next[2] ^ q[0]; // q_next[2] XOR with q[0]
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'h1; // Reset value
    end else begin
        q <= q_next; // Next state value
    end
end

endmodule
