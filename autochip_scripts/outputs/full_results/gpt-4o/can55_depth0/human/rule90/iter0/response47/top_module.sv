module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load the initial state
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    q[i] <= q[1]; // Left boundary cell
                end else if (i == 511) begin
                    q[i] <= q[510]; // Right boundary cell
                end else begin
                    q[i] <= q[i-1] ^ q[i+1]; // Rule 90: XOR of left and right neighbors
                end
            end
        end
    end
endmodule
