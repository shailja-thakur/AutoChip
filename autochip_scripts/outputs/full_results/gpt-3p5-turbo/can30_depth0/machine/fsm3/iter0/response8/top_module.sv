module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  // State encoding
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  reg [1:0] state;
  wire [1:0] next_state;

  assign next_state = getNextState(state, in);
  
  // State transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Output logic
  always @(posedge clk) begin
    if (state == D) begin
      out <= 1;
    end else begin
      out <= 0;
    end
  end

  // State transition logic
  function automatic [1:0] getNextState;
    input [1:0] currState;
    input in;

    begin
      case (currState)
        A: begin
          if (in == 1) begin
            getNextState = B;
          end else begin
            getNextState = A;
          end
        end
        B: begin
          if (in == 1) begin
            getNextState = B;
          end else begin
            getNextState = C;
          end
        end
        C: begin
          if (in == 1) begin
            getNextState = D;
          end else begin
            getNextState = A;
          end
        end
        D: begin
          if (in == 1) begin
            getNextState = B;
          end else begin
            getNextState = C;
          end
        end
      endcase
    end
  endfunction
endmodule
