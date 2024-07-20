module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);
    
    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = q[4:1]; // Shift right by removing LSB
        q_next[4] = q[0]; // Set MSB with LSB
        q_next[2] = q_next[2] ^ q[0]; // XOR operation
    end

    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Assign reset value
        end else begin
            q <= q_next; // Assign next state
        end
    end

endmodule
