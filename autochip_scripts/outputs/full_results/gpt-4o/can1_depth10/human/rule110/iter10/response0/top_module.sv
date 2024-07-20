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
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Left-most boundary
                    next_q[i] = (q[i] & q[i + 1]) | (~q[i] & q[i + 1]);
                end else if (i == 511) begin
                    // Right-most boundary
                    next_q[i] = (q[i - 1] & q[i]) | (q[i - 1] & ~q[i]);
                end else begin
                    next_q[i] = (q[i - 1] & q[i] & ~q[i + 1]) | (~q[i - 1] & q[i] & q[i + 1]) | (q[i - 1] & ~q[i] & q[i + 1]) | (~q[i - 1] & ~q[i] & q[i + 1]);
                end
            end
            
            q <= next_q;
        end
    end

endmodule
