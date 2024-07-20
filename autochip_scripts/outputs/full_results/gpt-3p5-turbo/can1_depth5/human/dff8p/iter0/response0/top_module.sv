module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

reg [7:0] q_temp;

always @(negedge clk) begin
    if (reset) begin
        q_temp <= 8'h34;
    end else begin
        q_temp <= d;
    end
end

assign q = q_temp;

endmodule
