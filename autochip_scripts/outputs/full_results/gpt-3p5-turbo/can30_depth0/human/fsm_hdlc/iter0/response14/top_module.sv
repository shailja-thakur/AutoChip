module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err
);

reg [2:0] state;
reg [5:0] counter;

parameter IDLE = 3'b000;
parameter ONE = 3'b001;
parameter TWO = 3'b010;
parameter THREE = 3'b011;
parameter FOUR = 3'b100;
parameter ERROR = 3'b101;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    counter <= 0;
    disc <= 0;
    flag <= 0;
    err <= 0;
  end else begin
    case(state)
      IDLE: begin
        if (in) begin
          state <= ONE;
          counter <= 1;
        end else begin
          state <= IDLE;
        end
      end
      ONE: begin
        if (in) begin
          state <= TWO;
          counter <= counter + 1;
        end else begin
          state <= IDLE;
        end
      end
      TWO: begin
        if (in) begin
          state <= THREE;
          counter <= counter + 1;
        end else begin
          state <= IDLE;
        end
      end
      THREE: begin
        if (in) begin
          if (counter == 5) begin
            state <= FOUR;
            counter <= 1;
          end else begin
            state <= THREE;
            counter <= counter + 1;
          end
        end else begin
          state <= IDLE;
        end
      end
      FOUR: begin
        if (in) begin
          if (counter == 6) begin
            state <= IDLE;
            counter <= 0;
            flag <= 1;
          end else if (counter == 7) begin
            state <= IDLE;
            counter <= 0;
            err <= 1;
          end else begin
            state <= THREE;
            counter <= 2;
          end
        end else begin
          state <= IDLE;
          disc <= 1;
        end
      end
      ERROR: begin
        if (in) begin
          if (counter < 6) begin
            state <= THREE;
            counter <= counter + 2;
            err <= 1;
          end else begin
            state <= ERROR;
            counter <= counter + 1;
          end
        end else begin
          state <= IDLE;
          counter <= 0;
        end
      end
    endcase
  end
end

endmodule
