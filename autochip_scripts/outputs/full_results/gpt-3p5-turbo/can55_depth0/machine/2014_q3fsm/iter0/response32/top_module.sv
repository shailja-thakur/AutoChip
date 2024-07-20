module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

// Define states as parameters
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam S10 = 3'b011;
localparam S11 = 3'b100;
localparam S20 = 3'b101;
localparam S21 = 3'b110;
localparam S22 = 3'b111;

// Define current and next state variables
reg [2:0] state;
reg [2:0] next_state;

// Define state transition conditions
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A;
  end else begin
    state <= next_state;
  end
end

// Define next state based on current state and input signals
always @* begin
  case (state)
    A: begin
      if (s) begin
        next_state = B;
      end else begin
        next_state = A;
      end
    end
    B: begin
      if (w) begin
        next_state = S11;
      end else begin
        next_state = S10;
      end
    end
    C: begin
      if (w) begin
        next_state = S11;
      end else begin
        next_state = S10;
      end
    end
    S10: begin
      if (w) begin
        next_state = S21;
      end else begin
        next_state = S20;
      end
    end
    S11: begin
      if (w) begin
        next_state = S22;
      end else begin
        next_state = S21;
      end
    end
    S20: begin
      next_state = B;
    end
    S21: begin
      if (w) begin
        next_state = C;
      end else begin
        next_state = B;
      end
    end
    S22: begin
      if (w) begin
        next_state = B;
      end else begin
        next_state = C;
      end
    end
    default: begin
      next_state = A;
    end
  endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    z <= 0;
  end else begin
    case (state)
      A: begin
        z <= 0;
      end
      B: begin
        z <= 0;
      end
      C: begin
        z <= 0;
      end
      S10: begin
        z <= 0;
      end
      S11: begin
        z <= 0;
      end
      S20: begin
        z <= 0;
      end
      S21: begin
        z <= 0;
      end
      S22: begin
        z <= 1;
      end
      default: begin
        z <= 0;
      end
    endcase
  end
end

endmodule
