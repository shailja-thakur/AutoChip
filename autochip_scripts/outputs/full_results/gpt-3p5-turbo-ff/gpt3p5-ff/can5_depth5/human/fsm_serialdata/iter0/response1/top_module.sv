module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  // Define the states of the FSM
  reg [2:0] state;
  
  // Define the inputs and outputs of the FSM
  reg start_bit;
  reg [7:0] data_bits;
  reg stop_bit;
  reg [7:0] received_byte;
  reg done;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000; // Initialize the FSM to the idle state
      start_bit <= 0; // Initialize the start bit to 0
      data_bits <= 0; // Initialize the data bits to 0
      stop_bit <= 1; // Initialize the stop bit to 1
      received_byte <= 0; // Initialize the received byte to 0
      done <= 0; // Initialize done to 0
    end else begin
      case(state)
        // Idle state
        3'b000: begin
          if (in == 1) begin
            state <= 3'b001; // Transition to the start bit state
            start_bit <= 1; // Store the start bit value
          end
        end
        
        // Start bit state
        3'b001: begin
          state <= 3'b010; // Transition to the data bit state
          data_bits <= 0; // Initialize the data bits
        end
        
        // Data bit state
        3'b010: begin
          data_bits <= {data_bits[6:0], in}; // Shift in the incoming data bit
          if (data_bits[7] == 1) begin
            state <= 3'b011; // Transition to the stop bit state
            stop_bit <= 0; // Store the stop bit value
          end
        end
        
        // Stop bit state
        3'b011: begin
          if (in == 1) begin
            state <= 3'b000; // Transition back to the idle state
            received_byte <= data_bits; // Store the received data byte
            done <= 1; // Assert done
          end
        end
      endcase
    end
  end

  assign out_byte = received_byte;
  
endmodule
