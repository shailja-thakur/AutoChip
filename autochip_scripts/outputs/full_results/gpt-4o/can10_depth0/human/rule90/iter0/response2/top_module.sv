module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            integer i;
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = 0 ^ q[i+1];     // q[-1] is considered 0
                else if (i == 511)
                    next_q[i] = q[i-1] ^ 0;    // q[512] is considered 0
                else
                    next_q[i] = q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end

endmodule
