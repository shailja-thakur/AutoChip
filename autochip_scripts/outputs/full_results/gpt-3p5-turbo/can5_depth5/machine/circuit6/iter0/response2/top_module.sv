module top_module (
    input [2:0] a, 
    output reg [15:0] q
);
   always @* begin
      case (a)
         0: q = 16'h1232;
         1: q = 16'hafc0;
         2: q = 16'h27A4;
         3: q = 16'h5A76;
         4: q = 16'h205A;
         5: q = 16'h644E;
         6: q = 16'hC5DE;
         7: q = 16'h2F49;
      endcase
   end
endmodule
