module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
  
  reg [7:0] sel_div;

  always @(sel)
    begin
      case(sel)
        0: sel_div <= 0;
        1: sel_div <= 4;
        2: sel_div <= 8;
        default: sel_div <= 0;
      endcase
    end

  always @(sel_div or in)
    begin
      case(sel_div)
        0: out <= in[3:0];
        1: out <= in[7:4];
        2: out <= in[11:8];
        default: out <= 0;
      endcase
    end

endmodule
