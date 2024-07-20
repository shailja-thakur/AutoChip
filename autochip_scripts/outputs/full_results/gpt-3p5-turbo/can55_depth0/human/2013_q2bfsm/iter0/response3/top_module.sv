module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  /* Define states */
  typedef enum logic [1:0] {
    A,
    B,
    C,
    D
  } state_type;
  
  /* Declare state and next_state variables */
  state_type state, next_state;
  
  /* Declare internal signals */
  logic reset_edge, x_1, x_2, x_3, y_1;
  
  /* State transitions */
  always_ff@(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  /* Output logic */
  always_comb begin
    f = 0;
    g = 0;
    
    case (state)
      A: begin
        f = 0;
        g = 0;
        if (!resetn) begin
          next_state = A;
        end else if (reset_edge) begin
          next_state = B;
          f = 1;
        end
      end
      
      B: begin
        f = 1;
        g = 0;
        if (x_1 && !x_2 && x_3) begin
          next_state = C;
        end else begin
          next_state = B;
        end
      end
      
      C: begin
        f = 1;
        g = 1;
        if (y_1) begin
          next_state = D;
        end else begin
          next_state = C;
        end
      end
      
      D: begin
        f = 0;
        g = 1;
        if (!y_1) begin
          next_state = A;
        end else begin
          next_state = D;
        end
      end
    endcase
  end
  
  /* Synchronous reset edge detection */
  always_ff@(negedge resetn) begin
    reset_edge <= !resetn;
  end
  
  /* Input delay flip-flops */
  always_ff@(posedge clk or negedge resetn) begin
    if (!resetn) begin
      x_1 <= 0;
      x_2 <= 0;
      x_3 <= 0;
      y_1 <= 0;
    end else begin
      x_1 <= x;
      x_2 <= x_1;
      x_3 <= x_2;
      y_1 <= y;
    end
  end
  
endmodule
