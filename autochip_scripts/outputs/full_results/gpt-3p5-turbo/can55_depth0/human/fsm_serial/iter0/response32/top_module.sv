module top_module (
    input clk,
    input in,
    input reset,
    output done
);
   
   reg [2:0] state;
   reg start_bit_detected;
   reg [7:0] data_bits;
   
   parameter IDLE = 3'b000;
   parameter START_BIT = 3'b001;
   parameter DATA_BITS = 3'b010;
   parameter STOP_BIT = 3'b011;
   
   always @(posedge clk or posedge reset) begin
      if(reset) begin
         state <= IDLE;
         start_bit_detected <= 0;
         data_bits <= 8'b0;
      end else begin
         case(state)
            IDLE: begin
               if(in == 1'b0) begin
                  start_bit_detected <= 1;
                  state <= START_BIT;
               end
            end
            
            START_BIT: begin
               state <= DATA_BITS;
            end
            
            DATA_BITS: begin
               data_bits <= {data_bits[6:0], in};
               if(data_bits == 8'b11111111) begin
                  state <= STOP_BIT;
               end
            end
            
            STOP_BIT: begin
               if(in == 1'b1) begin
                  state <= IDLE;
                  done <= 1;
               end
            end
         endcase
      end
   end
   
endmodule
