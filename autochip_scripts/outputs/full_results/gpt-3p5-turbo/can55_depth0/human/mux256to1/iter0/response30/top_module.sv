module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

reg [7:0] sel_index;

always @* begin
  case (sel)
    0: sel_index = 0;
    1: sel_index = 1;
    2: sel_index = 2;
    // ... continue the case statement until sel = 255
    default: sel_index = 0;
  endcase
end

assign out = in[sel_index];

endmodule
