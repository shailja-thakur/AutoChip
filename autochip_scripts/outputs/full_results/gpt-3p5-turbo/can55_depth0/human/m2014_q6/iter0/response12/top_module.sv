module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  // Define the states as parameters
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;
   
  // Define the current state, next state, and the next state register
  reg [2:0] state, next_state;
  
  // Assign the initial state
  initial state = A;
  
  // Declare the state transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // Define the next state logic
  always @(state or w) begin
    case (state)
      A: begin
        if (w) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
      
      B: begin
        if (w) begin
          next_state = D;
        end else begin
          next_state = C;
        end
      end
      
      C: begin
        if (w) begin
          next_state = D;
        end else begin
          next_state = E;
        end
      end
      
      D: begin
        if (w) begin
          next_state = A;
        end else begin
          next_state = F;
        end
      end
      
      E: begin
        if (w) begin
          next_state = D;
        end else begin
          next_state = E;
        end
      end
      
      F: begin
        if (w) begin
          next_state = D;
        end else begin
          next_state = C;
        end
      end
      
      default: next_state = A;
    endcase
  end
  
  // Declare the output logic
  always @(state) begin
    case (state)
      A: z = 1'b0;
      B: z = 1'b0;
      C: z = 1'b0;
      D: z = 1'b0;
      E: z = 1'b1;
      F: z = 1'b1;
      default: z = 1'b0;
    endcase
  end
  
endmodule
