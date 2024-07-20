module top_module (
   input clk,
   input in,
   input reset,
   output done
);
   
   reg [3:0] state;
   reg start_bit_detected;
   reg [7:0] data_bits;
   reg stop_bit_detected;
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 4'b0000;
         start_bit_detected <= 1'b0;
         data_bits <= 8'b0;
         stop_bit_detected <= 1'b0;
      end
      else begin
         case (state)
            4'b0000: begin // Idle state
               start_bit_detected <= 1'b0;
               stop_bit_detected <= 1'b0;
               data_bits <= 8'b0;
               if (in == 1'b0) begin
                  state <= 4'b0001; // Start bit detected
                  start_bit_detected <= 1'b1;
               end
            end
            
            4'b0001: begin // Start bit detected
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0010; // Wait for 8 data bits
            end
            
            4'b0010: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0011;
            end
            
            4'b0011: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0100;
            end
            
            4'b0100: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0101;
            end
            
            4'b0101: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0110;
            end
            
            4'b0110: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b0111;
            end
            
            4'b0111: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b1000;
            end
            
            4'b1000: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b1001;
            end
            
            4'b1001: begin // Wait for 8 data bits
               // Shift data bits
               data_bits <= {data_bits[6:0], in};
               state <= 4'b1010;
            end
            
            4'b1010: begin // Expecting stop bit
               stop_bit_detected <= 1'b1;
               if (in == 1'b1) begin
                  state <= 4'b1011;
               end
            end
            
            4'b1011: begin // Byte reception complete
               done <= 1'b1;
               state <= 4'b0000; // Return to idle state for next byte
            end
            
            default: begin
               state <= 4'b0000; // Return to idle state in case of unknown state
            end
         endcase
      end
   end
   
endmodule
