module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create a 4-bit output wire for each bit position in the output
wire [255:0] mux_outputs;

// Instantiate 256-to-1 multiplexers for each bit position in the output
generate
  genvar i;
  for (i = 0; i < 256; i = i + 1) begin : mux_insts
    mux4to1 mux (
      .in0(in[i*4 + 3:i*4]),
      .in1(in[i*4 + 7:i*4 + 4]),
      .in2(in[i*4 + 11:i*4 + 8]),
      .in3(in[i*4 + 15:i*4 + 12]),
      .sel(sel[7:0] == i),
      .out(mux_outputs[i])
    );
  end
endgenerate

// Concatenate all the outputs to form the 4-bit wide output
assign out = {mux_outputs};

// 4-to-1 multiplexer module definition
module mux4to1 (
  input [3:0] in0,
  input [3:0] in1,
  input [3:0] in2,
  input [3:0] in3,
  input sel,
  output reg [3:0] out
);
  always @(*) begin
    case (sel)
      0: out = in0;
      1: out = in1;
      2: out = in2;
      3: out = in3;
    endcase
  end
endmodule
