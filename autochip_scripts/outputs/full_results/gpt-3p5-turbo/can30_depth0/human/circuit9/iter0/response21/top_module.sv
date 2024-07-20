module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  // Declare a reg variable to store the previous value of "a"
  reg prev_a;

  always @(posedge clk) begin
    if (a == 1 && prev_a != 1) begin
      case (q)
        0: q <= 4;
        4: q <= 5;
        5: q <= 6;
        default: q <= 0;
      endcase
    end
    prev_a <= a;
  end

endmodule
