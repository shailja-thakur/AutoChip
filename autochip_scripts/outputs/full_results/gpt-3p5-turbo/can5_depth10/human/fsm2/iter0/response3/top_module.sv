module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  typedef enum logic [1:0] {OFF, ON} state_t;
  reg [1:0] state, next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case(state)
      OFF: begin
        if (j) begin
          next_state = ON;
        end else begin
          next_state = OFF;
        end
      end
      
      ON: begin
        if (k) begin
          next_state = OFF;
        end else begin
          next_state = ON;
        end
      end
    endcase
  end

  always @(state) begin
    case(state)
      OFF: out = 0;
      ON: out = 1;
    endcase
  end

endmodule
