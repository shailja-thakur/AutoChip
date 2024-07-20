module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case (state)
        3'b000: begin // state 0
          if (in) begin
            state <= 3'b001;
          end else begin
            state <= 3'b000;
          end
        end
        3'b001: begin // state 1
          if (in) begin
            state <= 3'b010;
          end else begin
            state <= 3'b000;
          end
        end
        3'b010: begin // state 2
          if (in) begin
            state <= 3'b011;
          end else begin
            state <= 3'b000;
          end
        end
        3'b011: begin // state 3
          if (in) begin
            disc <= 1;
            flag <= 0;
            err <= 0;
            state <= 3'b100;
          end else begin
            state <= 3'b100;
          end
        end
        3'b100: begin // state 4
          if (in) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            state <= 3'b100;
          end else begin
            state <= 3'b101;
          end
        end
        3'b101: begin // state 5
          if (in) begin
            err <= 1;
            disc <= 0;
            flag <= 0;
            state <= 3'b100;
          end else begin
            state <= 3'b000;
            err <= 0;
            disc <= 0;
            flag <= 0;
          end
        end
      endcase
    end
  end

endmodule
