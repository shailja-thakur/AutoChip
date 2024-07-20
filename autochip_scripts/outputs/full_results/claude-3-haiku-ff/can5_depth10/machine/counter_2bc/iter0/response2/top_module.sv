module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

  always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
      state <= 1'b1;
    end
    else if (train_valid) begin
      case (state)
        2'b00: begin
          if (train_taken) begin
            state <= 2'b01;
          end
          else begin
            state <= 2'b00;
          end
        end
        2'b01: begin
          if (train_taken) begin
            state <= 2'b10;
          end
          else begin
            state <= 2'b00;
          end
        end
        2'b10: begin
          if (train_taken) begin
            state <= 2'b11;
          end
          else begin
            state <= 2'b01;
          end
        end
        2'b11: begin
          if (train_taken) begin
            state <= 2'b11;
          end
          else begin
            state <= 2'b10;
          end
        end
        default: begin
          state <= 2'b01;
        end
      endcase
    end
  end

endmodule
