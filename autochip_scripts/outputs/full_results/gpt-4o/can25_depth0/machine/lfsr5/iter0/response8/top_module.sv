module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

reg [4:0] q_next;

// State transition always block
always @* begin
    q_next = {q[4:1], q[0]};  // assign q_next with q[4:1] and q[0]
    q_next[4] = q[0];         // assign q_next[4] with q[0]
    q_next[2] = q[2] ^ q[0];  // q_next[2] xored with q[0]
end

// Sequential logic always block
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'h1;            // Reset value
    end else begin
        q <= q_next;          // State transition
    end
end

endmodule
