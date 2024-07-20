module top_module (
	input [4:0] x,
	output logic f
);

  // Instantiate combinational logic block
  assign f = calculate_f(x);

  // Combinational logic block
  function logic calculate_f(input [4:0] x);
    begin
      case (x)
        5'b0000: calculate_f = 1'b1;
        5'b0001: calculate_f = 1'b1;
        5'b0010: calculate_f = 1'b0;
        5'b0011: calculate_f = 1'b0;
        5'b0100: calculate_f = 1'b1;
        5'b0101: calculate_f = 1'b1;
        5'b0110: calculate_f = 1'b1;
        5'b0111: calculate_f = 1'b0;
        5'b1000: calculate_f = 1'b0;
        5'b1001: calculate_f = 1'b0;
        5'b1010: calculate_f = 1'b0;
        5'b1011: calculate_f = 1'b0;
        5'b1100: calculate_f = 1'b1;
        5'b1101: calculate_f = 1'b0;
        5'b1110: calculate_f = 1'b1;
        5'b1111: calculate_f = 1'b1;
        default: calculate_f = 1'b0;
      endcase
    end
  endfunction

endmodule
