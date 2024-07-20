module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);
  
  parameter IDLE_STATE = 2'b00;
  parameter START_STATE = 2'b01;
  parameter DATA_STATE = 2'b10;
  
  reg [1:0] state;
  
  always @(posedge clk) begin
    if(reset) begin
      state <= IDLE_STATE;
      out_byte <= 8'b0;
      done <= 0;
    end
    else begin
      case(state)
        IDLE_STATE: begin
          if(in == 1'b0) begin
            state <= START_STATE;
            out_byte <= 8'b0;
            done <= 0;
          end
        end
        START_STATE: begin
          if(in == 1'b0) begin
            state <= DATA_STATE;
            out_byte <= 8'b0;
            done <= 0;
          end
        end
        DATA_STATE: begin
          out_byte <= {out_byte[6:0], in};
          if(out_byte[7] == 1'b1) begin
            state <= IDLE_STATE;
            done <= 1;
          end
        end
      endcase
    end
  end
  
endmodule
