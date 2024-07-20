module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    reg [511:0] next_q;

    integer i;
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q[0] <= q[1]; // special case for left boundary
            next_q[511] <= q[510]; // special case for right boundary
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] <= q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end
endmodule
