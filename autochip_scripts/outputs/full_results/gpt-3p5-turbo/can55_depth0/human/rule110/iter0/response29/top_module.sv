module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] temp_q;

    always @(posedge clk) begin
        if (load) begin
            temp_q <= data;
        end else begin
            temp_q[0] <= (q[1] & q[2]) | (q[1] & ~q[2]) | (~q[1] & q[2]) | (~q[1] & ~q[2]);
            temp_q[511] <= (q[510] & q[511]) | (q[510] & ~q[511]) | (~q[510] & q[511]) | (~q[510] & ~q[511]);
            for (i = 1; i <= 510; i = i + 1) begin
                temp_q[i] <= (q[i-1] & q[i] & q[i+1]) | (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & q[i] & q[i+1]) | (~q[i-1] & q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & ~q[i] & ~q[i+1]);
            end
        end
    end

    always @(posedge clk) begin
        if (!load) begin
            q <= temp_q;
        end
    end

endmodule
