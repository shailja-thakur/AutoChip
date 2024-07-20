module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    q[i] <= 1'b0 ^ q[i + 1]; // q[-1] is 0
                else if (i == 511)
                    q[i] <= q[i - 1] ^ 1'b0; // q[512] is 0
                else
                    q[i] <= q[i - 1] ^ q[i + 1];
            end
        end
    end

endmodule
