module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  // Define the states
  parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

  // Define the state registers
  reg [2:0] current_state;
  reg [2:0] next_state;

  // Define the outputs
  reg z;

  // Sequential and combinational logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  always @(current_state or w) begin
    case (current_state)
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
    endcase
  end

  always @(current_state) begin
    case (current_state)
      A: begin
        z = 0;
      end
      B: begin
        z = 0;
      end
      C: begin
        z = 0;
      end
      D: begin
        z = 0;
      end
      E: begin
        z = 1;
      end
      F: begin
        z = 1;
      end
    endcase
  end

endmodule
