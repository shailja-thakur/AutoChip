module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;
    
    // Always block for state transition logic
    always @(*) begin
        q_next = q[4:1];     // Assign q_next with q except the LSB bit
        q_next[4] = q[0];    // Assign q_next[4] with the LSB bit of q
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with the LSB bit
    end

    // Always block for sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;  // Assign reset value
        end else begin
            q <= q_next;  // Assign state transition
        end
    end
endmodule
