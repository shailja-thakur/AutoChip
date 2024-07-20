module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

   reg [3:0] state;
   reg [7:0] byte;
   reg [2:0] bit_count;

   parameter IDLE_STATE = 4'b0000;
   parameter START_STATE = 4'b0001;
   parameter DATA_STATE = 4'b0010;
   parameter STOP_STATE = 4'b0011;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= IDLE_STATE;
         bit_count <= 0;
         byte <= 0;
      end else begin
         case (state)
            IDLE_STATE:
               if (in == 1'b0) begin
                  state <= START_STATE;
                  bit_count <= 0;
                  byte <= 0;
               end
               else begin
                  state <= IDLE_STATE;
                  bit_count <= 0;
                  byte <= 0;
               end
            ;
            START_STATE:
               if (bit_count < 8) begin
                  state <= DATA_STATE;
                  bit_count <= bit_count + 1;
                  byte <= {in, byte[7:1]};
               end
               else begin
                  state <= STOP_STATE;
                  bit_count <= 0;
                  byte <= byte;
               end
            ;
            DATA_STATE:
               if (bit_count < 8) begin
                  state <= DATA_STATE;
                  bit_count <= bit_count + 1;
                  byte <= {in, byte[7:1]};
               end
               else begin
                  state <= STOP_STATE;
                  bit_count <= 0;
                  byte <= byte;
               end
            ;
            STOP_STATE:
               if (in == 1'b1) begin
                  state <= IDLE_STATE;
                  bit_count <= 0;
                  byte <= byte;
               end
               else begin
                  state <= STOP_STATE;
                  bit_count <= 0;
                  byte <= byte;
               end
            ;
            default: state <= IDLE_STATE;
         endcase
      end
   end

   assign out_byte = byte;
   assign done = (state == STOP_STATE);

endmodule
