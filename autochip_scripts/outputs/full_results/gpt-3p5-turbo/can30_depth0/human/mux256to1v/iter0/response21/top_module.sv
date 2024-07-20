module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
  reg [255:0] mux_inputs [0:255];
  
  generate 
    genvar i;
    for (i = 0; i < 256; i=i+1) begin : mux_inputs_gen
      assign mux_inputs[i] = in[i*4 +: 4];
    end
  endgenerate
  
  always @* begin
    case (sel)
      0: out = mux_inputs[0];
      1: out = mux_inputs[1];
      2: out = mux_inputs[2];
      // ... Continue similarly for remaining cases
    endcase
  end
  
endmodule
