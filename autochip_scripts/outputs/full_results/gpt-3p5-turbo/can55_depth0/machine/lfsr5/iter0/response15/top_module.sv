module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Declare a wire to store the next state of q
    wire [4:0] q_next;

    // State transition always block
    always @(q) begin
        // Assign q_next with q[4:1] (excluding the LSB)
        q_next[4:1] = q[3:0];

        // Assign q_next[4] with q[0] (LSB)
        q_next[4] = q[0];

        // XOR q_next[2] with q[0]
        q_next[2] = q[2] ^ q[0];
    end

    // Positive edge-triggered always block
    always @(posedge clk) begin
        // Check if reset is active
        if (reset) begin
            // Assign reset value to q
            q <= 5'h1;
        end else begin
            // Assign q_next to q
            q <= q_next;
        end
    end
    
endmodule
