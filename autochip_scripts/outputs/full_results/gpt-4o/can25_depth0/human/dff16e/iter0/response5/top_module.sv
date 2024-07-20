module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    // Sequential block to describe D flip-flops with synchronous reset and byte-enable
    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;  // Synchronous reset, clears the register
        end else begin
            if (byteena[0]) begin
                q[7:0] <= d[7:0];  // Write to lower byte if byteena[0] is enabled
            end
            if (byteena[1]) begin
                q[15:8] <= d[15:8];  // Write to upper byte if byteena[1] is enabled
            end
        end
    end
endmodule
