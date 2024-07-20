module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: State Transition Logic
    always @(q) begin
        q_next = q[4:1];  // Shift-right operation
        q_next[4] = q[0]; // LSB moves to MSB
        q_next[2] = q_next[2] ^ q[0]; // XOR LSB with q[2]
    end

    // Second always block: Sequential Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset state
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
