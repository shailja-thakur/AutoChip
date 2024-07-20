module top_module (
  input [255:0] in,
  input [7:0] sel,
  output reg out
);

always @*
begin
  case(sel)
    0: out = in[0];
    1: out = in[1];
    2: out = in[2];
    // add more cases for sel values 3 to 255
    default: out = 1'b0; // default output when sel is out of range
  endcase
end

endmodule
