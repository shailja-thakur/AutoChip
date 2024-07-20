module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // First always block: state transitions
    always @* begin
        q_next = {q[3:0], q[0]}; // Shift left with LSB bit appended at the MS position
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    // Second always block: state transition at posedge clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
