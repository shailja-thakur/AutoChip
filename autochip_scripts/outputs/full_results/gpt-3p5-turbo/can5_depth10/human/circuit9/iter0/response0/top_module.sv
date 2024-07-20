module top_module (
   input clk,
   input a,
   output reg [2:0] q
);
   always @(posedge clk) begin
      if (a == 1) begin
         case (q)
            4: q <= 4; //change the value of q to 4
            0: q <= 1; //change the value of q to 1
            default: q <= q; //no change
         endcase
      end else begin //if a == 0
         case (q)
            4: q <= 4; //no change
            1: q <= 5; //change the value of q to 5
            default: q <= q; //no change
         endcase
      end
   end
endmodule
