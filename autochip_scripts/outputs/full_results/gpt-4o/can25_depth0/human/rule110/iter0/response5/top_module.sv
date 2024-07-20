module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = (q[0] & q[1]) | (~q[0] & q[1]) | (q[1] & ~q[2]);
                end else if (i == 511) begin
                    next_q[i] = (q[510] & q[511]) | (q[511] & ~q[512]);
                end else begin
                    next_q[i] = (q[i-1] & q[i]) | (~q[i-1] & q[i]) | (q[i] & ~q[i+1]);
                end
            end
            q <= next_q;
        end
    end

endmodule
