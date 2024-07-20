module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

reg [4:0] lfsr;

always @(posedge clk or posedge reset) begin
    if (reset)
        lfsr <= 5'b1;
    else begin
        lfsr <= {lfsr[3] ^ lfsr[2], lfsr[4:1]};
    end
end

assign q = lfsr;

endmodule
