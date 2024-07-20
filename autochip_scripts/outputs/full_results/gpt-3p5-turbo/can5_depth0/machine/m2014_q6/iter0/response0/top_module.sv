module top_module (
    input clk,
    input reset,
    input w,
    output z
);
  
  reg [2:0] state, next_state;
  
  always @(posedge clk) begin
    if (reset == 1'b1) begin
      state <= 3'b000;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state or w) begin
    case (state)
      3'b000: begin // State A
        if (w == 1'b0) begin
          next_state = 3'b001; // Transition from A to B
        end else begin
          next_state = 3'b000; // Transition from A to A
        end
      end
      
      3'b001: begin // State B
        if (w == 1'b1) begin
          next_state = 3'b011; // Transition from B to D
        end else begin
          next_state = 3'b010; // Transition from B to C
        end
      end
      
      3'b010: begin // State C
        if (w == 1'b1) begin
          next_state = 3'b011; // Transition from C to D
        end else begin
          next_state = 3'b100; // Transition from C to E
        end
      end
      
      3'b011: begin // State D
        if (w == 1'b1) begin
          next_state = 3'b000; // Transition from D to A
        end else begin
          next_state = 3'b101; // Transition from D to F
        end
      end
      
      3'b100: begin // State E
        if (w == 1'b1) begin
          next_state = 3'b011; // Transition from E to D
        end else begin
          next_state = 3'b100; // Transition from E to E
        end
      end
      
      3'b101: begin // State F
        if (w == 1'b1) begin
          next_state = 3'b011; // Transition from F to D
        end else begin
          next_state = 3'b010; // Transition from F to C
        end
      end
    endcase
  end
  
  assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
  
endmodule
