module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q[0] = q[1];  // q[-1] is treated as 0, so q[-1] XOR q[1] = q[1]
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];  // Rule 90: next state based on left and right neighbors
            end
            next_q[511] = q[510];  // q[512] is treated as 0, so q[510] XOR q[512] = q[510]
            q <= next_q;
        end
    end

endmodule
