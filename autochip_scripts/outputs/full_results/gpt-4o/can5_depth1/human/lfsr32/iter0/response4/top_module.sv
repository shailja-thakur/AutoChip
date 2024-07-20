module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;  // Reset value of the LFSR
        else begin
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};  // Tapping positions at 32, 22, 2, and 1
        end
    end
endmodule
