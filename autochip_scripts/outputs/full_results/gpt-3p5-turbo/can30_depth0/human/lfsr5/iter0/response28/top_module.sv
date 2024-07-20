module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr;

    // Initialize LFSR to 1
    initial
    begin
        lfsr = 1;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            lfsr <= 1;
        else
            lfsr <= {lfsr[3] ^ lfsr[4], lfsr[2:0]};
    end

    assign q = lfsr;

endmodule
