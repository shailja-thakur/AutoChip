module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] q_next;

always @(*) begin
    q_next = q; // Assign the current value of q to q_next as the default
    q_next[4:1] = q[3:0]; // Assign the upper 4 bits of q_next to the lower 4 bits of q
    q_next[0] = q[4];     // Assign the LSB of q_next to the MSB of q
    q_next[2] = q[0] ^ q_next[2]; // Perform XOR operation on the LSB of q and bit 2 of q_next
end

always @(posedge clk) begin
    if (reset) begin
        q <= 5'h1; // Assign reset value of 5'h1 to q
    end else begin
        q <= q_next; // Assign the value of q_next to q
    end
end

endmodule
