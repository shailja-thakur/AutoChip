module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

   reg [31:0] shift_register;
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         shift_register <= 32'b1;
         q <= 32'b1;
      end else begin
         shift_register <= {shift_register[30:0], shift_register[22] ^ shift_register[2] ^ shift_register[1] ^ shift_register[0]};
         q <= shift_register;
      end
   end

endmodule
