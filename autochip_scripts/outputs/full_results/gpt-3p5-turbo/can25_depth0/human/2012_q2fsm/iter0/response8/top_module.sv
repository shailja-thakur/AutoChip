module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  // Define states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  parameter E = 2'b100;
  parameter F = 2'b101;

  // Define signals
  reg [2:0] current_state;
  reg [2:0] next_state;
  
  // Reset the state to A
  always @(posedge clk) begin
    if (reset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end
  
  // State table
  always @* begin
    case (current_state)
      A: begin
        if (w) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (w) begin
          next_state = C;
        end else begin
          next_state = D;
        end
      end
      C: begin
        if (w) begin
          next_state = E;
        end else begin
          next_state = D;
        end
      end
      D: begin
        if (w) begin
          next_state = F;
        end else begin
          next_state = A;
        end
      end
      E: begin
        if (w) begin
          next_state = E;
        end else begin
          next_state = D;
        end
      end
      F: begin
        if (w) begin
          next_state = C;
        end else begin
          next_state = D;
        end
      end
    endcase
  end
  
  // Output assignment
  always @* begin
    case (current_state)
      A, B, C, D: begin
        z = 0;
      end
      E, F: begin
        z = 1;
      end
    endcase
  end

endmodule
