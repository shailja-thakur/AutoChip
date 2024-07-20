module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    integer i;

    always @(*) begin
        // Create the next state of q based on the current state
        for (i = 0; i < 512; i = i + 1) begin
            // Boundaries are both considered zero, so handle accordingly
            if (i == 0) begin
                next_q[i] = q[1] | q[0];
            end
            else if (i == 511) begin
                next_q[i] = q[510] & (~q[511] | q[511]);
            end
            else begin
                next_q[i] = (q[i-1] & q[i] & ~q[i+1]) | (~q[i-1] & q[i] & q[i+1]) | (~q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]);
            end
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_q;
        end
    end
endmodule
