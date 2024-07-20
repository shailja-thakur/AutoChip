module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = q[4:1];      // Assign q_next with q except LSB bit
        q_next[4] = q[0];     // Assign q[0] (LSB bit) to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    // State update logic on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;        // Assign reset value to q
        end else begin
            q <= q_next;      // Assign state transition value to q
        end
    end

endmodule
