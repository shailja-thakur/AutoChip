module top_module (
   input [4:1] x,
   output logic f
 );

   always_comb
     case (x)
       4'd0: f = 0;
       4'd1: f = 0;
       4'd2: f = 1;
       4'd3: f = 0;
       4'd4: f = 0;
       4'd5: f = 1;
       4'd6: f = 1;
       4'd7: f = 1;
       4'd8: f = 0;
       default: f = 0;
     endcase

endmodule
