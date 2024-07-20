module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_temp;  // Temporary register for storing intermediate values

always @(posedge clk) begin
    q_temp <= d;  // Assign input d to q_temp on positive edge of clk
end

assign q = q_temp;

endmodule
