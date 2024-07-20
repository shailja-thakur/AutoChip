module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] lfsr;

always @(posedge clk) begin
    if (reset) begin
        lfsr <= 5'b00001;
    end
    else begin
        lfsr <= {lfsr[3:0], lfsr[4] ^ lfsr[2]};
    end
    q <= lfsr;
end

endmodule
