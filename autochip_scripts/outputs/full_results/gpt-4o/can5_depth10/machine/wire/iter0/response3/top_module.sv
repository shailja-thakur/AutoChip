module top_module(
  input wire clk,
  input wire rst,
  output reg [7:0] data_out,
  output reg valid_out
);

  // State encoding
  typedef enum logic [1:0] {
      IDLE = 2'b00,
      WAIT = 2'b01,
      PROCESS = 2'b10,
      DONE = 2'b11
  } state_t;

  state_t state, next_state;
  reg [7:0] counter;
  
  // State transition
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 8'b0;
      data_out <= 8'b0;
      valid_out <= 1'b0;
    end
    else begin
      state <= next_state;
      if (state == WAIT) counter <= counter + 1;
    end
  end
  
  // Next state logic
  always_comb begin
    case (state)
      IDLE: begin
        next_state = rst ? IDLE : WAIT;
        valid_out = 1'b0;
        if (rst) data_out = 8'b0;
      end
      WAIT: begin
        next_state = (counter == 8'd10) ? PROCESS : WAIT;
        valid_out = 1'b0;
        data_out = 8'b0;
      end
      PROCESS: begin
        next_state = DONE;
        valid_out = 1'b0;
        data_out = 8'b10101010; // Example data value
      end
      DONE: begin
        next_state = IDLE;
        valid_out = 1'b1;
      end
      default: begin
        next_state = IDLE;
        valid_out = 1'b0;
        data_out = 8'b0;
      end
    endcase
  end

endmodule
