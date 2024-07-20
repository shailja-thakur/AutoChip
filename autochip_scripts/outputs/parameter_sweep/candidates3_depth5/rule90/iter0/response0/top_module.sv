module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // Boundary condition (q[-1] and q[512]) as zero (off)
            q[0] = q[1] ^ q[512];
            for (int i = 1; i < 511; i = i + 1) begin
                q[i] = q[i-1] ^ q[i+1];
            end
            q[511] = q[510] ^ q[0];
        end
    end

endmodule
