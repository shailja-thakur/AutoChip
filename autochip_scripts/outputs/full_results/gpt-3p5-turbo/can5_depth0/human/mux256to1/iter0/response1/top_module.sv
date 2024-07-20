module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

reg [255:0] temp;

always @* begin
  case (sel)
    8'd0: temp <= in[0];
    8'd1: temp <= in[1];
    8'd2: temp <= in[2];
    // Add cases for other selections.
    // ...
    default: temp <= 0; // To avoid latching if sel is invalid.
  endcase
end

assign out = temp;

endmodule
