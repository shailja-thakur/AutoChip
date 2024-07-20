module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;
    
    always @(posedge clk or posedge reset)
        if (reset)
            q <= 1'b1;
        else
            q <= q_next;

    always @*
    begin
        q_next[31] = q[21] ^ q[1] ^ q[0];
        q_next[30:0] = q[31:1];
    end

endmodule
