module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] q_next;

always @* begin
    q_next = q[4:1];  // Assign the value of q except the LSB bit to q_next[3:0]
    q_next[4] = q[0]; // Assign the LSB bit of q to q_next[4]
    q_next[2] = q[2] ^ q[0]; // XOR q[2] with LSB bit of q
end

always @(posedge clk) begin
    if (reset) begin
        q <= 5'h1; // Assign reset value 5'h1 to q
    end else begin
        q <= q_next; // Assign q_next value to q
    end
end

endmodule
