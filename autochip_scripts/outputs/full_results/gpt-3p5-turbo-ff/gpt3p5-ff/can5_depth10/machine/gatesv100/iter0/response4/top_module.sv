module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
  
  wire [98:0] shifted_in;   // Creating a wire for the shifted input signal
  
  assign shifted_in = {in[98:0], in[99]};   // Assigning the shifted input signal
  
  assign out_both = in[99:1] & shifted_in;   // Performing bitwise AND operation to generate out_both signal
  
  assign out_any = in | shifted_in;   // Performing bitwise OR operation to generate out_any signal
  
  assign out_different = {in[0] ^ in[99], in[99:1] ^ shifted_in};   // Performing bitwise XOR operation to generate out_different signal
  
endmodule
