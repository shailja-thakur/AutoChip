module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [255:0] sel_bit;
  
  always @(*) begin
    case(sel)
      0: sel_bit = in[3:0];
      1: sel_bit = in[7:4];
      2: sel_bit = in[11:8];
      3: sel_bit = in[15:12];
      // Add more cases for all possible values of sel
      // ...
      default: sel_bit = 4'b0;
    endcase
  end
  
  assign out = sel_bit;
  
endmodule
