module top_module (
	input clk,
	input in,
	input areset,
	output out
);
 
 reg [1:0] state;
 
 always @(posedge clk or posedge areset)
 begin
   if (areset)
     state <= 2'b00;
   else
   begin
     case (state)
       2'b00: if (in) state <= 2'b01; else state <= 2'b00;
       2'b01: if (in) state <= 2'b01; else state <= 2'b10;
       2'b10: if (in) state <= 2'b11; else state <= 2'b00;
       2'b11: if (in) state <= 2'b01; else state <= 2'b10;
     endcase
   end
 end
 
 assign out = (state == 2'b11) ? 1'b1 : 1'b0;
 
endmodule
