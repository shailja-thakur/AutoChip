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
                    next_q[i] = q[1]; // left boundary is 0 (off)
                end else if (i == 511) begin
                    next_q[i] = q[510]; // right boundary is 0 (off)
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1]; // Rule 90: XOR of the neighbors
                end
            end
            q <= next_q;
        end
    end
endmodule
