module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
  reg [255:0] temp;
  
  always @(sel) begin
    case(sel)
      8'b00000000: temp = in[0];
      8'b00000001: temp = in[1];
      8'b00000010: temp = in[2];
      8'b00000011: temp = in[3];
      8'b00000100: temp = in[4];
      8'b00000101: temp = in[5];
      8'b00000110: temp = in[6];
      8'b00000111: temp = in[7];
      8'b00001000: temp = in[8];
      8'b00001001: temp = in[9];
      8'b00001010: temp = in[10];
      8'b00001011: temp = in[11];
      8'b00001100: temp = in[12];
      8'b00001101: temp = in[13];
      8'b00001110: temp = in[14];
      8'b00001111: temp = in[15];
      8'b00010000: temp = in[16];
      8'b00010001: temp = in[17];
      // Continue the pattern for all 256 bits in the input vector       
      default: temp = 0; // Default case when sel does not match any of the cases
    endcase
  end

  assign out = temp;
  
endmodule
