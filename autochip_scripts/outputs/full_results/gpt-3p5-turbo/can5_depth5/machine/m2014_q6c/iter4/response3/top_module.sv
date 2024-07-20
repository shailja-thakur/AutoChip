module top_module (
    input [6:1] y,
    input w,
    output wire Y2,
    output wire Y4
);
  
    wire [3:0] y_bits;
    wire [1:0] y4_bits;
  
    assign y_bits = {y[6], y[5], y[3], y[2]};
    assign y4_bits = {y[1], y[0]};
  
    assign Y2 = y_bits[0] & ~w;
    assign Y4 = y4_bits & w;

endmodule
