module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

  reg [1:0] state, next_state;

  always @(posedge clk or negedge aresetn) begin
    if (aresetn == 0) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end

  always @(state or x) begin
    case (state)
      2'b00: begin
        if (x == 1) begin
          next_state = 2'b01;
        end
      end

      2'b01: begin
        if (x == 0) begin
          next_state = 2'b00;
        end else begin
          next_state = 2'b10;
        end
      end

      2'b10: begin
        if (x == 1) begin
          next_state = 2'b11;
        end else begin
          next_state = 2'b00;
        end
      end

      2'b11: begin
        if (x == 0) begin
          next_state = 2'b00;
          z <= 1;
        end else begin
          next_state = 2'b10;
        end
      end
    endcase
  end

endmodule
