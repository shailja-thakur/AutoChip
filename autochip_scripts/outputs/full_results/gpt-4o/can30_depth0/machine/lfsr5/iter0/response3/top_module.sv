module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: State Transition Logic
    always @(*) begin
        q_next = {q[4:1], q[0]}; // q_next[4:1] = q[4:1], q_next[0] = q[0]
        q_next[4] = q[0];        // Assign LSB to MSB
        q_next[2] = q[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // Second always block: Sequential Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
