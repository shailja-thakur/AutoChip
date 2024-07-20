module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
  
  // Logic for out_both
  assign out_both[0] = in[0] & in[99];  // Neighbour of in[0] is in[99]
  generate  
    genvar i;
    for (i = 1; i < 99; i = i + 1) begin : both_loop
      assign out_both[i] = in[i] & in[i-1];
    end
  endgenerate
  
  // Logic for out_any
  generate  
    genvar j;
    for (j = 1; j < 99; j = j + 1) begin : any_loop
      assign out_any[j] = in[j] | in[j-1];
    end
  endgenerate
  assign out_any[0] = in[0];  // Neighbour of in[0] is in[1]
  assign out_any[99] = in[99];  // Neighbour of in[99] is in[0]
  
  // Logic for out_different
  assign out_different[0] = in[0] ^ in[99];  // Neighbour of in[0] is in[99]
  generate  
    genvar k;
    for (k = 1; k < 99; k = k + 1) begin : different_loop
      assign out_different[k] = in[k] ^ in[k-1];
    end
  endgenerate
  assign out_different[99] = in[99] ^ in[98];  // Neighbour of in[99] is in[98]
  
endmodule
