module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_reg; // create a register to hold the value of q

always @(posedge clk)
begin
    q_reg <= d; // assign the input value to the register
end

always @(posedge clk)
begin
    q <= q_reg; // assign the value of the register to the output
end

endmodule
