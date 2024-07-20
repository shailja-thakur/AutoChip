module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] new_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    new_q[i] = q[i+1]; // Left boundary case, q[-1] is 0
                else if (i == 511)
                    new_q[i] = q[i-1]; // Right boundary case, q[512] is 0
                else
                    new_q[i] = q[i-1] ^ q[i+1]; // XOR of the neighbors
            end
            q <= new_q;
        end
    end

endmodule
