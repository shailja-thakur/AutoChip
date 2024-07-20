module top_module (
  input c,
  input d,
  output [3:0] mux_in
);
  wire [3:0] mux_out; // output from 4-to-1 mux
  wire a, b;
  
  // Generate a and b signals based on c and d inputs
  assign a = ~c & ~d;
  assign b = c;
  
  // Connect a and b to mux_in inputs
  assign mux_in[0] = (a & b) ? 1'b1 : 1'b0;
  assign mux_in[1] = (a & ~b) ? 1'b1 : 1'b0;
  assign mux_in[2] = (~a & ~b) ? 1'b1 : 1'b0;
  assign mux_in[3] = (~a & b) ? 1'b1 : 1'b0;
  
  // Connect mux_in to mux_out using a 4-to-1 mux
  mux4to1 mux (
    .a(a),
    .b(b),
    .in0(mux_in[0]),
    .in1(mux_in[1]),
    .in2(mux_in[2]),
    .in3(mux_in[3]),
    .out(mux_out)
  );
endmodule
module mux4to1 (
  input a,
  input b,
  input in0,
  input in1,
  input in2,
  input in3,
  output reg out
);
  always @* begin
    case ({a, b})
      2'b00: out = in0;
      2'b01: out = in1;
      2'b10: out = in2;
      2'b11: out = in3;
    endcase
  end
endmodule
