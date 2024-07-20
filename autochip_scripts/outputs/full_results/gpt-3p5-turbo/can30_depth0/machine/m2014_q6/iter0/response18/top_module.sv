module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000; // set initial state to A
    end else begin
      state <= next_state;
    end
  end

  always @(state or w) begin
    case (state)
      3'b000: begin // state A
        if (w) begin
          next_state = 3'b000; // stay in state A
        end else begin
          next_state = 3'b001; // transition to state B
        end
      end
      
      3'b001: begin // state B
        if (w) begin
          next_state = 3'b011; // transition to state D
        end else begin
          next_state = 3'b010; // transition to state C
        end
      end
      
      3'b010: begin // state C
        if (w) begin
          next_state = 3'b011; // transition to state D
        end else begin
          next_state = 3'b100; // transition to state E
        end
      end
      
      3'b011: begin // state D
        if (w) begin
          next_state = 3'b000; // transition to state A
        end else begin
          next_state = 3'b101; // transition to state F
        end
      end
      
      3'b100: begin // state E
        if (w) begin
          next_state = 3'b011; // transition to state D
        end else begin
          next_state = 3'b100; // stay in state E
        end
      end
      
      3'b101: begin // state F
        if (w) begin
          next_state = 3'b011; // transition to state D
        end else begin
          next_state = 3'b010; // transition to state C
        end
      end
    endcase
  end

  always @(state) begin
    if (state == 3'b100 || state == 3'b101) begin // state E or F
      z = 1'b1;
    end else begin
      z = 1'b0;
    end
  end

endmodule
