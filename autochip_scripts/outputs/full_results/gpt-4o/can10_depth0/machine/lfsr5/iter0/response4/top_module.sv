module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = {q[3:0], q[0]};  // Shift left and wrap around the LSB
        q_next[2] = q_next[2] ^ q[0];  // XOR the 3rd bit with the original LSB
    end

    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;  // Reset value
        else
            q <= q_next;  // Next state value
    end

endmodule
