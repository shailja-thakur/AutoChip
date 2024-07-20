module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [99:0] in_shift;
  reg [98:0] out_both_temp;
  reg [99:0] out_any_temp;
  reg [99:0] out_different_temp;

  always @* begin
    // Calculate out_both
    out_both_temp = in[99:1] & in[98:0];
    
    // Calculate out_any
    out_any_temp[1:99] = in_shift[0:98] | in_shift[1:99];
    
    // Calculate out_different
    out_different_temp = in_shift ^ in;
  end

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      in_shift <= 0;
    end else begin
      in_shift <= in;
    end
  end

  assign out_both = out_both_temp;
  assign out_any = out_any_temp;
  assign out_different = out_different_temp;

endmodule
