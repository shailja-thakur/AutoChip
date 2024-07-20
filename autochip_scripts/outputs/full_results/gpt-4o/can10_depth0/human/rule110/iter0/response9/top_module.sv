module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    integer i;
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Compute the next state
            next_q[0] = q[1] & q[0]; // Boundary case (q[-1] is 0)
            next_q[511] = q[510] | q[511]; // Boundary case (q[512] is 0)
            
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i-1] & q[i] & ~q[i+1]) |  // 1 1 0 -> 1
                            (q[i-1] & ~q[i] & q[i+1]) |  // 1 0 1 -> 1
                            (~q[i-1] & q[i] & q[i+1]) |  // 0 1 1 -> 1
                            (q[i-1] & q[i] & q[i+1]);    // 1 1 1 -> 0 (handled by initial 1 1 0 case)
            end
            
            q <= next_q;
        end
    end
endmodule
