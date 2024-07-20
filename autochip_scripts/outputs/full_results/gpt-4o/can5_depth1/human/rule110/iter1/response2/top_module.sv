module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate the next state based on Rule 110
            next_q[0] <= q[1]; // for q[0], assume q[-1] = 0
            next_q[511] <= q[510]; // for q[511], assume q[512] = 0

            // Calculate next state for q[1] to q[510]
            for (integer i = 1; i < 511; i = i + 1) begin
                next_q[i] <= (q[i-1] & q[i] & ~q[i+1]) |
                             (q[i-1] & ~q[i] & q[i+1]) |
                             (~q[i-1] & q[i] & ~q[i+1]) |
                             (~q[i-1] & ~q[i] & q[i+1]);
            end

            q <= next_q;
        end
    end
endmodule
