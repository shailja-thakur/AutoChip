module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  // Define states using parameters
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  parameter E = 2'b100;
  parameter F = 2'b101;

  reg [2:0] state;
  reg [2:0] next_state;

  // State transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic
  always @* begin
    case (state)
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
  always @(state, w) begin
    case (state)
      E, F: begin
        z = 1'b1;
      end
      default: begin
        z = 1'b0;
      end
    endcase
  end

endmodule
