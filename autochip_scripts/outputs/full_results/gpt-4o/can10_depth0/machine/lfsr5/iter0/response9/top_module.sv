module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = {q[4:1], q[0]}; // q[4:1] concatenated with q[0]
        q_next[4] = q[0];        // Assign LSB to MSB
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] xored with q[0]
    end

    // Register state update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // state transition
    end

endmodule
