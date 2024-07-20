module top_module (
	input clk,
	input in,
	input areset,
	output out
);
  
  reg [1:0] state;
  wire reset;
  
  assign reset = (areset == 1'b1);
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b01;
    end else if (state == 2'b00) begin
      if (in == 1'b0) begin
        state <= 2'b01;
      end else begin
        state <= 2'b00;
      end
    end else if (state == 2'b01) begin
      if (in == 1'b0) begin
        state <= 2'b10;
      end else begin
        state <= 2'b01;
      end
    end else if (state == 2'b10) begin
      if (in == 1'b0) begin
        state <= 2'b01;
      end else begin
        state <= 2'b10;
      end
    end
  end
  
  assign out = (state == 2'b01);
  
endmodule
