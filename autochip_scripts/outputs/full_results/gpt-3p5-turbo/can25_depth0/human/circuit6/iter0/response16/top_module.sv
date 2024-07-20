module top_module (
	input [2:0] a, 
	output reg [15:0] q
);
  always @(a) begin
    case(a)
      3'b000: begin
        q <= 16'b000000100110010;
      end
      3'b001: begin
        q <= 16'b101011101110000;
      end
      3'b010: begin
        q <= 16'b001001111010100;
      end
      3'b011: begin
        q <= 16'b001000000110011;
      end
      3'b100: begin
        q <= 16'b0110010011001110;
      end
      3'b101: begin
        q <= 16'b1100100100011101;
      end
      3'b110: begin
        q <= 16'b1100001010100110;
      end
      3'b111: begin
        q <= 16'b0010011101011101;
      end
      default: begin
        q <= 16'bxxxxxxxxxxxxxxxx;
      end
    endcase
  end
endmodule
