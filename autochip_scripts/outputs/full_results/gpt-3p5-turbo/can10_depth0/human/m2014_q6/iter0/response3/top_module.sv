module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  // State enumeration 
  typedef enum logic [2:0] {
    A,
    B,
    C,
    D,
    E,
    F
  } state_type;

  // Register to store current state
  reg state_type current_state;
  
  // State transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A;
    end 
    else if (w) begin
      case(current_state)
        A: current_state <= B;
        B: current_state <= D;
        C: current_state <= D;
        D: current_state <= A;
        E: current_state <= D;
        F: current_state <= D;
      endcase
    end 
    else begin
      case(current_state)
        A: current_state <= A;
        B: current_state <= C;
        C: current_state <= E;
        D: current_state <= F;
        E: current_state <= E;
        F: current_state <= C;
      endcase
    end
  end
  
  // Output logic
  always @(current_state) begin
    case(current_state)
      A: z = 0;
      B: z = 0;
      C: z = 0;
      D: z = 0;
      E: z = 1;
      F: z = 1;
    endcase
  end

endmodule
