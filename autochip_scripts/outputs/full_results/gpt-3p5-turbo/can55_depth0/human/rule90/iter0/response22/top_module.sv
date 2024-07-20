module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // process each cell
            for (integer i = 0; i < 512; i = i + 1) begin
                if (i == 0) // left boundary
                    q[i] <= (q[i] ^ q[i+1]);
                else if (i == 511) // right boundary
                    q[i] <= (q[i-1] ^ q[i]);
                else // internal cells
                    q[i] <= (q[i-1] ^ q[i+1]);
            end
        end
    end

endmodule
