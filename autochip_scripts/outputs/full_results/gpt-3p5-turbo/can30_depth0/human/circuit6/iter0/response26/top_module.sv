module top_module (
    input [2:0] a,
    output reg [15:0] q
);

   always @* begin
      case(a)
         0 : q = 1232;
         1 : q = "aee0";
         2 : q = "27d4";
         3 : q = "5a0e";
         4 : q = "2066";
         5 : q = "64ce";
         6 : q = "c526";
         7 : q = "2f19";
         default : q = 16'hxxxx; // This represents an unknown value
      endcase
   end
endmodule
