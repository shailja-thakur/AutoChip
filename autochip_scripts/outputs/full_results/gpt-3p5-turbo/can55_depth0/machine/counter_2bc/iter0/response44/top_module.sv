module top_module(
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

  logic [1:0] next_state;
  
  always_ff @(posedge clk or negedge areset) begin
    if (areset == 0) begin
      state <= 1;
    end
    else begin
      case (state)
        0: begin
          if (train_taken) begin
            next_state <= 1;
          end
          else begin
            next_state <= 0;
          end
        end
        
        1: begin
          if (train_taken) begin
            next_state <= 2;
          end
          else begin
            next_state <= 1;
          end
        end
        
        2: begin
          if (train_taken) begin
            next_state <= 3;
          end
          else begin
            next_state <= 1;
          end
        end
        
        3: begin
          if (train_taken) begin
            next_state <= 3;
          end
          else begin
            next_state <= 2;
          end
        end
        
        default: next_state <= 1;
      endcase
    end
  end
  
  always_comb begin
    state <= next_state;
  end

endmodule
