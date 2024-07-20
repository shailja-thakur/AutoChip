module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;

    always @(*) begin
        q_next[0] = (q[1] == 1'b1) ? 1'b1 : 1'b0; // q[-1] is 0
        q_next[511] = (q[510] == 1'b1) ? 1'b1 : 1'b0; // q[512] is 0
        
        for (int i = 1; i < 511; i = i + 1) begin
            q_next[i] = (q[i - 1] & q[i] & q[i + 1]) ? 1'b0 :
                        (q[i - 1] & q[i] & ~q[i + 1]) ? 1'b1 :
                        (q[i - 1] & ~q[i] & q[i + 1]) ? 1'b1 :
                        (q[i - 1] & ~q[i] & ~q[i + 1]) ? 1'b0 :
                        (~q[i - 1] & q[i] & q[i + 1]) ? 1'b1 :
                        (~q[i - 1] & q[i] & ~q[i + 1]) ? 1'b1 :
                        (~q[i - 1] & ~q[i] & q[i + 1]) ? 1'b1 : 1'b0;
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end

endmodule
