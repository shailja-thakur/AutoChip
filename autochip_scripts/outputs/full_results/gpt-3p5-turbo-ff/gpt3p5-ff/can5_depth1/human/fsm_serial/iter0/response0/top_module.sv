module top_module (
   input clk,
   input in,
   input reset,
   output done
);
   
   reg [3:0] state;
   reg start_bit_detected;
   reg [7:0] data_bits;
   
   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 4'b0000;
      else begin
         case (state)
            4'b0000: begin
               if (in == 1'b0)
                  start_bit_detected <= 1'b1;
               state <= 4'b0001;
            end
            4'b0001: begin
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0011;
            end
            4'b0011: begin
               state <= 4'b0100;
            end
            4'b0100: begin
               if (in == 1'b1) begin
                  if (start_bit_detected == 1'b1) begin
                     done <= 1'b1;
                     start_bit_detected <= 1'b0;
                  end
                  state <= 4'b0000;
               end
               else
                  state <= 4'b0100;
            end
         endcase
      end
   end
   
endmodule
