module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] lfsr;

    always @(posedge clk) begin
        if (reset) begin
            lfsr <= 32'b1;
            q <= 32'b1;
        end else begin
            lfsr <= {lfsr[21:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            q <= lfsr;
        end
    end
endmodule
