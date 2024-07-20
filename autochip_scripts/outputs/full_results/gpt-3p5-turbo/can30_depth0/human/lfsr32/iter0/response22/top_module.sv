module top_module(
    input wire clk,
    input wire reset,
    output reg [31:0] q);

    reg [31:0] lfsr;

    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr <= 32'h1;
        else
            lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
    end

    assign q = lfsr;

endmodule
