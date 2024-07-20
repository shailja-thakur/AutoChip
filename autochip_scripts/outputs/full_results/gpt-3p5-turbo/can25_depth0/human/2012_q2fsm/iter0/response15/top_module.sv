module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  reg [2:0] state, next_state;

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  always @(state, w) begin
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

  always @(state) begin
    case (state)
      A: begin
        z = 1'b0;
      end
      B: begin
        z = 1'b0;
      end
      C: begin
        z = 1'b0;
      end
      D: begin
        z = 1'b0;
      end
      E: begin
        z = 1'b1;
      end
      F: begin
        z = 1'b1;
      end
    endcase
  end

endmodule
