module top_module (
   input clk,
   input areset,
   input x,
   output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;
  
  parameter IDLE = 3'b000;
  parameter CONVERT = 3'b001;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always @(state, x) begin
    case (state)
      IDLE: begin
        z <= 1'b0;
        next_state <= (areset) ? IDLE : CONVERT;
      end
      CONVERT: begin
        z <= ~x + 1;
        next_state <= (areset) ? IDLE : CONVERT;
      end
    endcase
  end

endmodule
