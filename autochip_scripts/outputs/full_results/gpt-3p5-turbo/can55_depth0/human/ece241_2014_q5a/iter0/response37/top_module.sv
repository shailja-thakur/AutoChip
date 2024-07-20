module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  // Define states
  typedef enum logic [2:0] {
    STATE_IDLE = 3'b000,
    STATE_CONVERT = 3'b001
  } state_t;

  // Define state register
  reg [2:0] state;

  // Define internal signals
  reg x_msb;
  reg x_neg;

  // Define state outputs
  assign z = x_neg;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (!areset && x == 1'b0) begin
            state <= STATE_CONVERT;
            x_msb <= 1'b1;
            x_neg <= 1'b0;
          end
        end
        STATE_CONVERT: begin
          if (x_msb) begin
            if (x == 1'b0) begin
              x_msb <= 1'b0;
            end
          end else begin
            state <= STATE_IDLE;
            x_neg <= 1'b1;
          end
        end
      endcase
    end
  end
endmodule
