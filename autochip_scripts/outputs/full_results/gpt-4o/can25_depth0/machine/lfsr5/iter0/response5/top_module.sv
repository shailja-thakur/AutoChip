module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = q[4:1];    // Assign bits [4:1] of q to q_next
        q_next[4] = q[0];   // Assign LSB of q to q_next[4]
        q_next[2] = q_next[2] ^ q[0];   // XOR q_next[2] with LSB of q
    end

    // Sequential logic for state update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;    // Reset value of q
        end else begin
            q <= q_next;  // State transition
        end
    end

endmodule
