module top_module (
   input [99:0] in,
   output [98:0] out_both,
   output [99:1] out_any,
   output [99:0] out_different
);

   reg [98:0] temp_both;
   reg [99:0] temp_any;
   reg [99:0] temp_different;
   
   always @(*)
   begin
      for (int i=0; i<99; i=i+1)
      begin
         if (in[i] & in[i+1])
            temp_both[i] = 1;
         else
            temp_both[i] = 0;

         if (in[i] | in[i+1])
            temp_any[i] = 1;
         else
            temp_any[i] = 0;
            
         if (in[i] == in[i+1])
            temp_different[i] = 0;
         else
            temp_different[i] = 1;
      end
   end
   
   assign out_both = temp_both;
   assign out_any = temp_any[1:99];
   assign out_different = temp_different;
   
endmodule
