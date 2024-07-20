module top_module (
   input [4:1] x,
   output logic f
);
   always_comb begin
      case(x)
         4'b00??: f = 1; // d = don't care, can be any value
         4'b01??: f = x[3] & x[4]; // d = 0
         4'b11??: f = 1; // d = don't care, can be any value
         4'b10??: f = x[3] & ~x[4]; // d = don't care, can be any value
         default: f = 0; // for any other input combination
      endcase
   end
endmodule
