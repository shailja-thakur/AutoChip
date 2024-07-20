module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        integer i;
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    q[i] <= q[i+1];  // q[-1] is 0, hence only q[i+1]
                end else if (i == 511) begin
                    q[i] <= q[i-1];  // q[512] is 0, hence only q[i-1]
                end else begin
                    q[i] <= q[i-1] ^ q[i+1];
                end
            end
        end
    end

endmodule
