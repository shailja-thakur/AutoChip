module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] d;
wire [2:0] not_d;
wire x_xor_d;
wire x_and_not_d;
wire x_or_not_d;

assign x_xor_d = x ^ d[1];
assign x_and_not_d = x & ~d[2];
assign x_or_not_d = x | ~d[0];

assign z = x_xor_d & x_and_not_d & x_or_not_d;

always @(posedge clk) begin
    d <= {d[1:0], x_xor_d};
end

initial begin
    d <= 3'b0;
    #5 $finish;
end

endmodule
