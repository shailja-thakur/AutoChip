module top_module (
  input c,
  input d,
  output [3:0] mux_in
);
  
  wire a, b;
  wire out0, out1, out2, out3;
  
  // Implementing the K-map using 2-to-1 multiplexers.
  // Mux1
  mux2to1 m1 (.in0(c), .in1(~d), .sel(a), .out(out0));
  
  // Mux2
  mux2to1 m2 (.in0(~c), .in1(~d), .sel(a), .out(out1));
  
  // Mux3
  mux2to1 m3 (.in0(~c), .in1(d), .sel(a), .out(out2));
  
  // Mux4
  mux2to1 m4 (.in0(~c), .in1(~d), .sel(b), .out(out3));
  
  // Connecting four outputs to mux inputs.
  assign mux_in[0] = out0;
  assign mux_in[1] = out1;
  assign mux_in[2] = out2;
  assign mux_in[3] = out3;
  
  // Implementing the 4-to-1 multiplexer to combine the outputs of the 2-to-1 multiplexers.
  mux4to1 m5 (.in0(mux_in[0]), .in1(mux_in[1]), .in2(mux_in[2]), .in3(mux_in[3]), .sel({a, b}), .out(mux_out));
  
endmodule
module mux2to1 (
  input in0,
  input in1,
  input sel,
  output out
);
  assign out = (sel == 0) ? in0 : in1;
endmodule
module mux4to1 (
  input in0,
  input in1,
  input in2,
  input in3,
  input [1:0] sel,
  output out
);
  reg out;
  always @(sel or in0 or in1 or in2 or in3) begin
    case(sel)
      2'b00: out = in0;
      2'b01: out = in1;
      2'b10: out = in2;
      2'b11: out = in3;
    endcase
  end
endmodule
