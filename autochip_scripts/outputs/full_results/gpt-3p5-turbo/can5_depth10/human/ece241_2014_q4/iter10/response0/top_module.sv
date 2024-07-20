module top_module (
    input clk,
    input x,
    output reg z
);

reg [3:0] d;
wire x_xor_d;
wire x_and_not_d;
wire x_or_not_d;

assign x_xor_d = x ^ d[1];
assign x_and_not_d = x & ~d[2];
assign x_or_not_d = x | ~d[3];

assign z = x_xor_d & x_and_not_d & x_or_not_d;

always @(posedge clk) begin
    d <= {d[2:0], x_xor_d};
end

initial begin
    d <= 4'b0;
end

endmodule
