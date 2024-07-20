module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = q[4:1];       // Assign q_next with q except the LSB bit
        q_next[4] = q[0];      // Assign q_next[4] with the LSB bit of q
        q_next[2] = q[2] ^ q[0]; // XOR q_next[2] with the LSB bit of q
    end

    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;         // Reset value
        else
            q <= q_next;       // State transition
    end
    
endmodule
