module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    // Internal register to store next value of q
    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        // If reset is high, set q to initial value 32'h1
        if (reset) 
            q <= 32'h1;
        else
            q <= q_next;
    end

    always @(*) begin
        // Calculate next value for q
        q_next[31] = q[0];
        q_next[30:1] = q[31:1];
        q_next[0] = q[21] ^ q[1] ^ q[0];
    end

endmodule
