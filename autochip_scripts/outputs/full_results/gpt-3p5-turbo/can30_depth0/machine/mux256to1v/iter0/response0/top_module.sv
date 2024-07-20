module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
  
  always @*
  begin
    case(sel)
      8'b0000: out = in[3:0]; // Select the first 4-bit block from input vector
      8'b0001: out = in[7:4]; // Select the second 4-bit block from input vector
      8'b0010: out = in[11:8]; // Select the third 4-bit block from input vector
      8'b0011: out = in[15:12]; // Select the fourth 4-bit block from input vector
      8'b0100: out = in[19:16]; // Select the fifth 4-bit block from input vector
      8'b0101: out = in[23:20]; // Select the sixth 4-bit block from input vector
      8'b0110: out = in[27:24]; // Select the seventh 4-bit block from input vector
      8'b0111: out = in[31:28]; // Select the eighth 4-bit block from input vector
      8'b1000: out = in[35:32]; // Select the ninth 4-bit block from input vector
      8'b1001: out = in[39:36]; // Select the tenth 4-bit block from input vector
      8'b1010: out = in[43:40]; // Select the eleventh 4-bit block from input vector
      8'b1011: out = in[47:44]; // Select the twelfth 4-bit block from input vector
      8'b1100: out = in[51:48]; // Select the thirteenth 4-bit block from input vector
      8'b1101: out = in[55:52]; // Select the fourteenth 4-bit block from input vector
      8'b1110: out = in[59:56]; // Select the fifteenth 4-bit block from input vector
      8'b1111: out = in[63:60]; // Select the sixteenth 4-bit block from input vector
      default: out = 4'b0000; // Default case, output is all zeros
    endcase
  end
  
endmodule
