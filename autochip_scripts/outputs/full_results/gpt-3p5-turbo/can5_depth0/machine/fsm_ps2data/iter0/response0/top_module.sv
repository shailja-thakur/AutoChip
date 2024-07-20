module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg [23:0] out_bytes,
   output reg done
);

   reg [1:0] state;
   reg [23:0] reg_data;

   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= BYTE1;
      else begin
         case (state)
            BYTE1:
               if (in[2] == 1'b1) 
                  state <= BYTE2;
               else
                  state <= BYTE1;
            BYTE2:
               if (in[2] == 1'b1) 
                  state <= BYTE3;
               else
                  state <= BYTE1;
            BYTE3:
               if (in[2] == 1'b1) 
                  state <= DONE;
               else
                  state <= BYTE1;
            DONE:
               if (done)
                  state <= BYTE1;
               else
                  state <= DONE;
         endcase
      end
   end

   always @(posedge clk) begin
      if (reset)
         reg_data <= 0;
      else if (done)
         reg_data <= (out_bytes & 24'hFFFFFF) | (in << 16);
      else
         reg_data <= reg_data << 8;
   end

   always @* begin
      if (state == DONE)
         done = 1;
      else
         done = 0;

      out_bytes = reg_data;
   end

endmodule
