module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end 
        else begin
            reg [511:0] next_q;
            // Compute next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] <= (q[i+1]) ? q[0] | q[1] : q[0] & q[1];
                end
                else if (i == 511) begin
                    next_q[i] <= (q[i-1]) ? q[510] | q[511] : q[510] & q[511];
                end
                else begin
                    next_q[i] <= (q[i-1] & q[i] & q[i+1]) ? 1'b0 : // 111 -> 0
                                 (q[i-1] & q[i] & ~q[i+1]) ? 1'b1 : // 110 -> 1
                                 (q[i-1] & ~q[i] & q[i+1]) ? 1'b1 : // 101 -> 1
                                 (q[i-1] & ~q[i] & ~q[i+1]) ? 1'b0 : // 100 -> 0
                                 (~q[i-1] & q[i] & q[i+1]) ? 1'b1 : // 011 -> 1
                                 (~q[i-1] & q[i] & ~q[i+1]) ? 1'b1 : // 010 -> 1
                                 (~q[i-1] & ~q[i] & q[i+1]) ? 1'b1 : // 001 -> 1
                                 1'b0; // 000 -> 0
                end
            end
            q <= next_q;
        end
    end
endmodule
