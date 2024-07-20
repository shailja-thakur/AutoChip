module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
reg is_first_byte;
wire valid_message;


assign valid_message = (byte1[3] == 1) && (byte2[3] == 0) && (byte3[3] == 0);

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin
        if (in[3] == 1)
          is_first_byte <= 1;
        else
          is_first_byte <= 0;
          
        byte1 <= in;
        
        if (is_first_byte)
          state <= 1;
      end
      1: begin
        byte2 <= in;
        state <= 2;
      end
      2: begin
        byte3 <= in;
        state <= 3;
      end
      3: begin
        if (valid_message)
          done <= 1;
        state <= 0;
      end
      default: state <= 0;
    endcase
  end
end

endmodule
