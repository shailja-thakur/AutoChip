module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1];     // q_next is assigned with q[4:1]
        q_next[4] = q[0];    // q_next[4] is assigned with q[0] (the LSB bit)
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 5'h1;       // Reset value
        else 
            q <= q_next;     // State transition
    end

endmodule
