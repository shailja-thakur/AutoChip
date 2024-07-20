module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = q[1]; // q[-1] is 0, so next_q[0] = q[1]
                else if (i == 511)
                    next_q[i] = q[510]; // q[512] is 0, so next_q[511] = q[510]
                else
                    next_q[i] = q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end
endmodule
