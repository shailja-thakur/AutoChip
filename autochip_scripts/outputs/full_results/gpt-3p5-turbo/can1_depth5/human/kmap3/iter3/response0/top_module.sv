module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
  );

  always @(a or b or c or d) begin
    case({c, d, a, b})

      // Output for inputs 0000, 0100, 1110, 1000 => 1
      4'b0000, 4'b0100, 4'b1110, 4'b1000: out = 1;

      // Output for inputs 0001, 0010, 0011, 0110, 0111 => 0
      4'b0001, 4'b0010, 4'b0011, 4'b0110, 4'b0111: out = 0;
      
      // Output for inputs 0101 => d
      4'b0101: out = d;

      // Output for inputs 1100, 1101, 1111 => 0
      4'b1100, 4'b1101, 4'b1111: out = 0;

      // Output for all other inputs
      default: out = 0;
    endcase
  end

endmodule
