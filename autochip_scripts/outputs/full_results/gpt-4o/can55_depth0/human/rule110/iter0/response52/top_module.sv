module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        integer i;
        next_q = 512'b0;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                // Leftmost cell
                next_q[i] = (q[i+1] & q[i]) |
                            (~q[i] & q[i+1]);
            end else if (i == 511) begin
                // Rightmost cell
                next_q[i] = (q[i-1] & q[i]) |
                            (q[i-1] & ~q[i]);
            end else begin
                // General case
                next_q[i] = (q[i-1] & ~q[i+1]) |
                            (q[i-1] & q[i+1]) |
                            (~q[i-1] & q[i] & q[i+1]);
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
