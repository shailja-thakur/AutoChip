module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b01; // reset to state 1
    end
    else if (train_valid) begin
      case (state)
        2'b00: begin
          if (train_taken) begin
            state <= 2'b01; // transition to state 1
          end
          else begin
            state <= 2'b00; // remain in state 0
          end
        end
        2'b01: begin
          if (train_taken) begin
            state <= 2'b10; // transition to state 2
          end
          else begin
            state <= 2'b00; // transition to state 0
          end
        end
        2'b10: begin
          if (train_taken) begin
            state <= 2'b11; // transition to state 3
          end
          else begin
            state <= 2'b01; // transition to state 1
          end
        end
        2'b11: begin
          if (train_taken) begin
            state <= 2'b11; // remain in state 3
          end
          else begin
            state <= 2'b10; // transition to state 2
          end
        end
        default: begin
          state <= 2'b01; // reset to state 1
        end
      endcase
    end
  end

endmodule
