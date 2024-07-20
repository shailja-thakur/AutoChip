module top_module (
	input clk,
	input [7:0] in,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [2:0] state;
wire third_bit;

// Calculate the third bit of input
assign third_bit = in[2]; 

// FSM 
always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    state <= BYTE1;
    done <= 0;
    out_reg <= 0;
  end
  else
  begin
    case(state)
      BYTE1:
      begin
        if (third_bit)
          state <= BYTE2;
        else
          state <= BYTE1;
        out_reg <= {out_reg[15:0], in};
      end
      BYTE2:
      begin
        if (third_bit)
          state <= BYTE3;
        else
          state <= BYTE1;
        out_reg <= {out_reg[15:0], in};
      end
      BYTE3:
      begin
        if (third_bit)
          state <= DONE;
        else
          state <= BYTE1;
        out_reg <= {out_reg[15:0], in};
      end
      DONE:
      begin
        if (third_bit)
          state <= DONE;
        else
          state <= BYTE1;
        out_reg <= {out_reg[15:0], in};
      end
    endcase
    done <= (state == DONE);
  end
end

assign out_bytes = done ? out_reg : 0;

endmodule
