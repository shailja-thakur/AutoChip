module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block to define the state transition of q
    always @* begin
        q_next = q[4:1];     // Assign q_next with q except the LSB bit
        q_next[4] = q[0];    // Assign q_next MSB with q LSB
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    // Always block for state transition on positive edge of clk or active reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;       // Reset q to 5'h1
        else
            q <= q_next;     // Assign q with q_next
    end
endmodule
