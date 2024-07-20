module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define the states
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;

  reg [1:0] state;
  reg done_out;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      done_out <= 0;
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1) begin
            state <= BYTE2;
          end
        end
        BYTE2: begin
          state <= BYTE3;
        end
        BYTE3: begin
          state <= DONE;
        end
        DONE: begin
          if (in[2] == 0) begin
            state <= BYTE1;
          end else begin
            state <= BYTE2;
          end
        end
      endcase
      if (state == DONE) begin
        done_out <= 1;
      end else begin
        done_out <= 0;
      end
    end
  end
  
  assign done = done_out;
  
endmodule
