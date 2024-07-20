module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Define intermediate signal for next state
    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = {q[0], q[4:1]}; // q_next[4] <= q[0] and q_next[3:0] <= q[4:1]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] <= q_next[2] XOR q[0]
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset condition
        end else begin
            q <= q_next; // State transition
        end
    end
endmodule
