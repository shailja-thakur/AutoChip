module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;   // Reset state
        end else begin
            // Shift the register and apply the Galois LFSR feedback equation
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
        end
    end
endmodule
