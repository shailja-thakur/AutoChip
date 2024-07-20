module top_module (
  input [2:0] a, 
  output reg [15:0] q
);
  
  always @(*) begin
    case(a)
      3'b000: q = 16'h123A; // assign value 4658 to 'q' when 'a' is 0
      3'b001: q = 16'hAEA0; // assign value 44768 to 'q' when 'a' is 1
      3'b010: q = 16'h2864; // assign value 10196 to 'q' when 'a' is 2
      3'b011: q = 16'h59E6; // assign value 23054 to 'q' when 'a' is 3
      3'b100: q = 16'h205A; // assign value 8294 to 'q' when 'a' is 4
      3'b101: q = 16'h64E6; // assign value 25806 to 'q' when 'a' is 5
      3'b110: q = 16'hC556; // assign value 50470 to 'q' when 'a' is 6
      3'b111: q = 16'h2F49; // assign value 12057 to 'q' when 'a' is 7
    endcase
  end

endmodule
