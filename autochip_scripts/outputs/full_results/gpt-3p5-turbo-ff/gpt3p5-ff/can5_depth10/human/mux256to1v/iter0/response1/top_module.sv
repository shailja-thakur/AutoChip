module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

wire [255:0] in_arr [0:255];
wire [255:0] filtered_in;
genvar i;

// Unpacking the input vector
generate
  for (i = 0; i < 256; i=i+1) begin : UNPACK
    assign in_arr[i] = in[(i*4)+3:i*4];
  end
endgenerate

// Selecting the appropriate input based on the selection signal
assign filtered_in = (sel < 256) ? in_arr[sel] : 8'b0;

// Output
assign out = filtered_in[3:0];

endmodule
