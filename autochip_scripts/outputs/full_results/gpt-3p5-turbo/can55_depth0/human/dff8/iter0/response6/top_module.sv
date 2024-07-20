module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

reg [7:0] q_temp;  // Temporary register to hold the intermediate state during each clock cycle

always @(posedge clk) begin
    q_temp <= d;  // Assign input d to temporary register q_temp on every positive edge of clk
end

always @(posedge clk) begin
    q <= q_temp;  // Assign the value of q_temp to the output register q on every positive edge of clk
end

endmodule
