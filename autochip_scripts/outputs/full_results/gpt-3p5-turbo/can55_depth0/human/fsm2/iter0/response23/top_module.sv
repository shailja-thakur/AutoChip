module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b0;
    end else begin
      case(state)
        2'b00: begin // OFF
          if (j) begin
            state <= 2'b01;
          end else begin
            state <= 2'b00;
          end
        end

        2'b01: begin // ON
          if (k) begin
            state <= 2'b00;
          end else begin
            state <= 2'b01;
          end
        end

        default: begin
          state <= 2'b00;
        end
      endcase
    end
  end
  
  assign out = state[0];
  
endmodule
