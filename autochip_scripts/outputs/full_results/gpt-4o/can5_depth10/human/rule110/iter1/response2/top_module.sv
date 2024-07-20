module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0)
                next_q[i] = (q[1] == 1 && q[0] == 0) || (q[1] == 0 && q[0] == 1);
            else if (i == 511)
                next_q[i] = (q[510] == 1 && q[511] == 0) || (q[510] == 0 && q[511] == 1);
            else
                next_q[i] = (q[i-1] & ~q[i] & q[i+1]) | (q[i] & ~q[i-1]) | (q[i+1] & q[i]);
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
