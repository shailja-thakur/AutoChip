module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] lfsr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 32'b1;
            q <= 32'b1;
        end else begin
            lfsr <= {lfsr[30:0], lfsr[0] ^ lfsr[20] ^ lfsr[30] ^ lfsr[31]};
            q <= lfsr;
        end
    end
endmodule
