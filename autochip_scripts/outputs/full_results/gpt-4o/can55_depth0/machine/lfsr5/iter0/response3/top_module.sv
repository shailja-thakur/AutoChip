module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1];         // Shift right
        q_next[4] = q[0];        // Rotate the LSB to MSB
        q_next[2] = q_next[2] ^ q[0]; // XOR operation
    end

    // State update
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;           // Reset value
        else
            q <= q_next;         // Update state
    end

endmodule
