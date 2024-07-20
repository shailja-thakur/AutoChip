module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
  
  reg [7:0] data;    // Register to store the received data byte
  reg [2:0] state;   // Finite State Machine (FSM) state
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 0;     // Reset the FSM state
    end else begin
      case(state)
        0: begin       // Wait for the start bit
          if(in == 0) begin
            state <= 1;
            data <= 0;  // Reset the data register
          end
        end
        1: begin       // Receive the 8 data bits
          data <= {data[6:0], in};
          if(data == 8'd255) begin
            state <= 2;
          end
        end
        2: begin       // Verify the stop bit
          if(in == 1) begin
            out_byte <= data;
            done <= 1;
            state <= 0; // Reset the FSM state
          end else begin
            state <= 2; // Wait for the correct stop bit
          end
        end
      endcase
    end
  end

endmodule
