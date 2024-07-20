module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

   reg [2:0] state;
   reg [7:0] data_byte;
   reg        start_bit_detected, stop_bit_detected;
   reg [3:0] bit_count;

   always @(posedge clk or posedge reset) begin
      if (reset == 1) begin
         state <= 0;
         data_byte <= 8'b0;
         start_bit_detected <= 0;
         stop_bit_detected <= 0;
         bit_count <= 0;
      end else begin
         case (state)

            // Idle state, waiting for start bit
            0: begin
               if (in == 0) begin
                  state <= 1; // Transition to receive data bits
                  start_bit_detected <= 1;
                  data_byte <= 8'b0;
                  bit_count <= 0;
               end else begin
                  state <= 0; // Stay in idle state
               end
            end

            // Receive data bits
            1: begin
               if (bit_count < 8) begin
                  data_byte <= {in, data_byte[7:1]}; // Shift in the received bit
                  bit_count <= bit_count + 1;
               end else begin
                  state <= 2; // Transition to receive stop bit
               end
            end

            // Receive stop bit
            2: begin
               if (in == 1) begin
                  stop_bit_detected <= 1;
               end
               state <= 0; // Transition back to idle state
            end

            default: state <= 0; // If the state is undefined, go back to idle state

         endcase
      end
   end

   // Output the received byte and done signal
   assign out_byte = data_byte;
   assign done = stop_bit_detected;

endmodule
