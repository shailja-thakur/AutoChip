module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Compute the next state of each cell based on the rule
        for (int i = 0; i < 512; i++) begin
            next_state[i] = (i == 0) ? 0 : // q[-1] is assumed to be 0
                           (i == 511) ? 0 : // q[512] is assumed to be 0
                           ((q[i-1] & q[i] & q[i+1]) | 
                            (q[i-1] & q[i] & ~q[i+1]) |
                            (q[i-1] & ~q[i] & q[i+1]) |
                            (~q[i-1] & q[i] & q[i+1]));
        end
        q <= next_state;
    end
end

endmodule
