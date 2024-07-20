module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  reg [1:0] state; // 2-bit state register

  always @(posedge clk or posedge areset) begin
    if (areset == 1) begin
      state <= 2'b00; // reset to state A
    end else begin
      case (state)
        2'b00: begin // state A
          if (in == 1) begin
            state <= 2'b01; // next state B
          end else begin
            state <= 2'b00; // next state A
          end
        end
        
        2'b01: begin // state B
          if (in == 1) begin
            state <= 2'b01; // next state B
          end else begin
            state <= 2'b10; // next state C
          end
        end
        
        2'b10: begin // state C
          if (in == 1) begin
            state <= 2'b11; // next state D
          end else begin
            state <= 2'b00; // next state A
          end
        end
        
        2'b11: begin // state D
          if (in == 1) begin
            state <= 2'b01; // next state B
          end else begin
            state <= 2'b10; // next state C
          end
        end
      endcase
    end
  end

  assign out = (state == 2'b11); // set out to 1 when state is D

endmodule
