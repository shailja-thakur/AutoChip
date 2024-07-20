module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] next_q;
            next_q[0] = q[1]; // Left neighbour is 0 (boundary condition)
            next_q[511] = q[510]; // Right neighbour is 0 (boundary condition)
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end
endmodule
