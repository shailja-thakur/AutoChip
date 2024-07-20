module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
  reg [23:0] reg_bytes;
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin
          if (in[2] == 1)
            state <= 2'b01;
          else
            state <= 2'b00;
        end
        2'b01: begin
          state <= 2'b10;
        end
        2'b10: begin
          state <= 2'b11;
        end
        2'b11: begin
          state <= 2'b00;
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (reset)
      reg_bytes <= 24'b0;
    else begin
      case (state)
        2'b00: begin
          reg_bytes <= reg_bytes << 8;
        end
        2'b01: begin
          reg_bytes <= {reg_bytes[15:0], in};
        end
      endcase
    end
  end
  
  assign out_bytes = (state == 2'b11) ? reg_bytes[23:0] : 0;
  assign done = (state == 2'b11) ? 1 : 0;
  
endmodule
