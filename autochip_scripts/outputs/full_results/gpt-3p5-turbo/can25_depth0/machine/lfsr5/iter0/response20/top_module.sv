module top_module(
    input clk,
    input reset,
    output [4:0] q);

    reg [4:0] q_next;

    // state transition
    always @(q) begin
        q_next[4:1] = q[3:0];
        q_next[4] = q[0];
        q_next[2] = q[2] ^ q[0];
    end

    // Next state assignment
    always @(posedge clk) begin
        if (reset)
            q <= 5'b00001;
        else
            q <= q_next;
    end

endmodule
