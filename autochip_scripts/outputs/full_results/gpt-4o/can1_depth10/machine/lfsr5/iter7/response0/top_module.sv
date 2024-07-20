module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: State transition logic
    always @(*)
    begin
        q_next = q; // Initialize q_next with the current value of q
        q_next[3:0] = q[4:1]; // q_next[3:0] = q[4:1]
        q_next[4] = q[0]; // q_next[4] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] = q_next[2] XOR q[0]
    end

    // Second always block: State update
    always @(posedge clk)
    begin
        if (reset)
            q <= 5'h1; // Reset the output to 5'h1
        else
            q <= q_next; // Update q with q_next at positive edge of clk
    end
endmodule
