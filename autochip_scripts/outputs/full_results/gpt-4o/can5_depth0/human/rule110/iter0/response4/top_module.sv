module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;

    integer i;

    always @(*) begin
        q_next[0] = (q[1] == 1) ? 1 : 0; // Left boundary
        q_next[511] = (q[510] == 1) ? 1 : 0; // Right boundary

        for (i = 1; i < 511; i = i + 1) begin
            if (q[i - 1] && q[i] && q[i + 1])
                q_next[i] = 0;
            else if (q[i - 1] && q[i] && !q[i + 1])
                q_next[i] = 1;
            else if (q[i - 1] && !q[i] && q[i + 1])
                q_next[i] = 1;
            else if (q[i - 1] && !q[i] && !q[i + 1])
                q_next[i] = 0;
            else if (!q[i - 1] && q[i] && q[i + 1])
                q_next[i] = 1;
            else if (!q[i - 1] && q[i] && !q[i + 1])
                q_next[i] = 1;
            else if (!q[i - 1] && !q[i] && q[i + 1])
                q_next[i] = 1;
            else 
                q_next[i] = 0;
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end

endmodule
