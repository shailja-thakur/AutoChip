module top_module (
    input clk,
    input in,
    output logic out
);

// Define signals and the D flip flop
reg d;
always @(posedge clk)
    d <= in ^ out;

// Define output
assign out = d;

endmodule
