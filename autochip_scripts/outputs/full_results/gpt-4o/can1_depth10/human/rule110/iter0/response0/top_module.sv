module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Temporary registers to store the next state of the cellular automaton
    reg [511:0] next_q;
    
    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                // Handle the boundaries by checking if we're at the edges and treating out-of-bound indices as 0
                if (i == 0) begin
                    next_q[i] <= (q[1] & q[0]) | (~q[1] & q[0]);
                end else if (i == 511) begin
                    next_q[i] <= (q[510] & q[511]) | (~q[510] & q[511]) | (q[510] & ~q[511]);
                end else begin
                    next_q[i] <= (q[i+1] & q[i]) | (~q[i+1] & q[i]) | (q[i-1] & q[i]);
                end
            end
            q <= next_q;
        end
    end
endmodule
