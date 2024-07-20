module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q[0] <= q[31];
            q[1] <= q[0];
            q[2] <= q[1] ^ q[31];
            q[21] <= q[20];
            q[22] <= q[21] ^ q[31];
            q[30] <= q[29];
            q[31] <= q[30] ^ q[31] ^ q[21] ^ q[1];
            
            // For the rest of the bits
            for (integer i = 3; i < 31; i = i + 1) begin
                if (i != 21 && i != 22) begin
                    q[i] <= q[i-1];
                end
            end
        end
    end
endmodule
