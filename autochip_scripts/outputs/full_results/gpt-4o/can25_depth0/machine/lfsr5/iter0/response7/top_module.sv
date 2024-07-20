module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] q_next;

// Always block for state transition of q
always @* begin
    q_next = q[4:1];    // Assign q_next with q except the LSB bit
    q_next[4] = q[0];   // Assign q_next[4] with the LSB bit of q
    q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with the LSB bit of q
end

// Always block for updating q at positive edge of clk or when reset is active
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'h1; // Reset the q to 5'h1
    end else begin
        q <= q_next; // Update q with q_next
    end
end

endmodule
