module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] lfsr;
reg [4:0] tap;
reg feedback;

always @(posedge clk, posedge reset) begin
    if (reset)
        lfsr <= 5'b1;
    else
        lfsr <= {lfsr[2:0], feedback};
end

assign feedback = lfsr[4] ^ lfsr[2];

always @(posedge clk) begin
    if (reset)
        q <= 5'b1;
    else
        q <= lfsr;
end

endmodule
