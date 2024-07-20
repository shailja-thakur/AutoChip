module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Combinational logic: determine next state of 'q'
    always @(*) begin
        q_next = {q[2:0], q[4], q[0]};  // q_next[4] = q[0], q_next[3:1] = q[4:2], q_next[0] = q[1]
        q_next[2] = q_next[2] ^ q[0];  // XOR q[2] with q[0]
    end

    // Sequential logic: update 'q' on the positive edge of the clock or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Asynchronous reset
        else
            q <= q_next;  // State transition
    end 

endmodule
