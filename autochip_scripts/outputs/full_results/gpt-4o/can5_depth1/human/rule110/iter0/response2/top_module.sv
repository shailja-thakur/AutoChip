module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    // q[-1] is 0 for the leftmost cell
                    next_q[i] = (0 & q[i] & q[i+1]) | (0 & q[i] & ~q[i+1]) |
                                (0 & ~q[i] & q[i+1]) | (~0 & q[i] & ~q[i+1]);
                else if (i == 511)
                    // q[512] is 0 for the rightmost cell
                    next_q[i] = (q[i-1] & q[i] & 0) | (q[i-1] & q[i] & ~0) |
                                (q[i-1] & ~q[i] & 0) | (~q[i-1] & q[i] & ~0);
                else
                    // intermediary cells
                    next_q[i] = (q[i-1] & q[i] & q[i+1]) | (q[i-1] & q[i] & ~q[i+1]) |
                                (q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & q[i] & ~q[i+1]);
            end
            q <= next_q;
        end
    end

endmodule
