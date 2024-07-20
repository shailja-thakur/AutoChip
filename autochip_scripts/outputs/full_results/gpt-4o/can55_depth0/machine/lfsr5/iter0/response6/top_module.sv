module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(*) begin
        q_next = {q[3:0], q[0]}; // Get q[4:1], then assign q_next[4] with q[0]
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 5'h1;
        else 
            q <= q_next;
    end

endmodule
