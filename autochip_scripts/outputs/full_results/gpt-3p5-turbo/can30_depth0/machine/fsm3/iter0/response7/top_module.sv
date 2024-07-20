module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  reg [1:0] state;
  wire next_state;
  
  always @(posedge clk) begin
    if (areset) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end
  
  assign out = (state == 2'b11);
  
  always @(state or in) begin
    case (state)
      2'b00 : if (in) begin
                next_state = 2'b01;
              end else begin
                next_state = 2'b00;
              end
      2'b01 : if (in) begin
                next_state = 2'b01;
              end else begin
                next_state = 2'b10;
              end
      2'b10 : if (in) begin
                next_state = 2'b11;
              end else begin
                next_state = 2'b00;
              end
      2'b11 : if (in) begin
                next_state = 2'b01;
              end else begin
                next_state = 2'b10;
              end
    endcase
  end
  
endmodule
