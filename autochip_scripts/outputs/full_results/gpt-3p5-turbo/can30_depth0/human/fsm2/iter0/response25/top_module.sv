module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state;
  wire qn;
  wire [1:0] next_state;

  assign qn = ~state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b0;
    end
    else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      2'b00: begin
        out = 1'b0;
        if (j) begin
          next_state = 2'b01;
        end
        else begin
          next_state = 2'b00;
        end
      end

      2'b01: begin
        out = 1'b1;
        if (k) begin
          next_state = 2'b00;
        end
        else begin
          next_state = 2'b01;
        end
      end

      default: begin
        out = 1'b0;
        next_state = 2'b00;
      end
    endcase
  end

endmodule
