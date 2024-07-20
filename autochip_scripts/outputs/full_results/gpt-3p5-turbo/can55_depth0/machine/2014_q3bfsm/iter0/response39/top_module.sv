module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b001; // initial state A
    end else begin
      state <= next_state;
    end
  end
  
  always @(state, x) begin
    case (state)
      3'b001: begin // state A
        if (x) begin
          next_state = 3'b010; // transition to state B
        end else begin
          next_state = 3'b001; // remain in state A
        end
      end
      3'b010: begin // state B
        if (x) begin
          next_state = 3'b101; // transition to state E
        end else begin
          next_state = 3'b010; // remain in state B
        end
      end
      3'b011: begin // state C
        if (x) begin
          next_state = 3'b010; // transition to state B
        end else begin
          next_state = 3'b011; // remain in state C
        end
      end
      3'b100: begin // state D
        if (x) begin
          next_state = 3'b011; // transition to state C
        end else begin
          next_state = 3'b010; // transition to state B
        end
      end
      3'b101: begin // state E
        if (x) begin
          next_state = 3'b101; // remain in state E
        end else begin
          next_state = 3'b100; // transition to state D
        end
      end
    endcase
  end
  
  always @(state) begin
    if (state == 3'b101 || state == 3'b100) begin // state D or E
      z = 1'b1; // set output high
    end else begin
      z = 1'b0; // set output low
    end
  end

endmodule
