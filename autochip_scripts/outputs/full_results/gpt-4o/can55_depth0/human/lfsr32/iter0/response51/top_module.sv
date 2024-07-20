module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;  // Reset the LFSR to 1 on reset
        end
        else begin
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};  // Shift and apply tap XORs
        end
    end
endmodule
