module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        // Handle the boundaries (assuming q[-1] and q[512] are both 0)
        next_q[0] = (q[1] && q[0]) || (!q[1] && q[0] && q[511]) || (q[1] && !q[0] && q[511]);
        next_q[511] = (q[510] && q[511]) || (!q[510] && q[511] && q[0]) || (q[510] && !q[511] && q[0]);

        // Iterate through the cells and compute the next state
        for (int i = 1; i < 511; i = i + 1) begin
            next_q[i] = (q[i-1] && q[i]) || (!q[i-1] && q[i] && q[i+1]) || (q[i-1] && !q[i] && q[i+1]);
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule
