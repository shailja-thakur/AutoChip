module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
  reg [1:0] state;
  reg [23:0] temp;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      temp <= 0;
    end else begin
      case(state)
        0: begin // Idle state
          if (in[3]) begin
            state <= 1;
          end
        end
          
        1: begin // Byte 1 state
          temp[23:16] <= in;
          state <= 2;
        end
          
        2: begin // Byte 2 state
          temp[15:8] <= in;
          state <= 3;
        end
          
        3: begin // Byte 3 state
          temp[7:0] <= in;
          state <= 0;
          out_bytes <= temp;
          done <= 1;
        end
      endcase
    end
  end
  
  assign done = state == 3;
endmodule
