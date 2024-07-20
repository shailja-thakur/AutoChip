module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

reg [7:0] temp_q;

always @(posedge clk) begin
    if (reset)
        temp_q <= 8'b0;
    else
        temp_q <= d;
end

assign q = temp_q;

endmodule
