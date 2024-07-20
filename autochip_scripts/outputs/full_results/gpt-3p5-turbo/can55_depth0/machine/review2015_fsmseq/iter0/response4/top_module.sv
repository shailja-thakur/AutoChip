module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting
);

  reg [1:0] state;
  wire next_state;
  
  assign start_shifting = (state == 2'b11); // Output is high if state is Done, low otherwise
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00; // Reset to initial state (S)
    end else begin
      state <= next_state; // Update state based on next_state
    end
  end
  
  // Combinational logic block to determine next_state based on current state and data input
  always @(*) begin
    case(state)
      2'b00: begin
        if (data) begin
          next_state = 2'b01; // Next state is S1 if data is high
        end else begin
          next_state = 2'b00; // Next state is S if data is low
        end
      end
      
      2'b01: begin
        if (data) begin
          next_state = 2'b11; // Next state is S11 if data is high
        end else begin
          next_state = 2'b00; // Next state is S if data is low
        end
      end
      
      2'b11: begin
        if (data) begin
          next_state = 2'b11; // Next state is S11 if data is high
        end else begin
          next_state = 2'b10; // Next state is S110 if data is low
        end
      end
      
      2'b10: begin
        if (data) begin
          next_state = 2'b11; // Next state is Done if data is high
        end else begin
          next_state = 2'b00; // Next state is S if data is low
        end
      end
    endcase
  end
  
endmodule
