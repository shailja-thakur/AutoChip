module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // For the first cell, left neighbor is assumed to be 0
                    next_q[0] = 0 ^ q[0] ^ q[1];
                end else if (i == 511) begin
                    // For the last cell, right neighbor is assumed to be 0
                    next_q[511] = q[510] ^ q[511] ^ 0;
                end else begin
                    // For other cells, normal neighbors
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_q;
        end
    end

endmodule
