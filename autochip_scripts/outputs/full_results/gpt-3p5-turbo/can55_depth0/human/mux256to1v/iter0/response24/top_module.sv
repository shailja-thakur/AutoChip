module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
  
  wire [3:0] mux_out;
  wire [9:0] index;
  
  // Generate the index
  always @* begin
    case(sel)
      0: index = 10'b0000000000;
      1: index = 10'b0000000001;
      2: index = 10'b0000000010;
      3: index = 10'b0000000011;
      4: index = 10'b0000000100;
      5: index = 10'b0000000101;
      6: index = 10'b0000000110;
      7: index = 10'b0000000111;
      8: index = 10'b0000001000;
      9: index = 10'b0000001001;
      10: index = 10'b0000001010;
      11: index = 10'b0000001011;
      12: index = 10'b0000001100;
      13: index = 10'b0000001101;
      14: index = 10'b0000001110;
      15: index = 10'b0000001111;
      // Add more cases for larger multiplexers
      default: index = 10'b0000000000;
    endcase
  end
  
  // Generate the multiplexer output
  assign mux_out = in[{index[9]}, {index[8]}, {index[7]}, {index[6]}, {index[5]}, {index[4]}, {index[3]}, {index[2]}, {index[1]}, {index[0]}];
  
  // Assign output
  assign out = mux_out;
  
endmodule
