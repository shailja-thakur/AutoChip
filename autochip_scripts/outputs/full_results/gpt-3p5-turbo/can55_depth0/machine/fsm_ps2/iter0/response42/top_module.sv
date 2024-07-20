module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define states
  reg [1:0] state;
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;

  // Flip-flop to store the third bit of the input
  reg bit3;

  // Next state logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      bit3 <= 1'b0;
    end
    else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1)
            state <= BYTE2;
          else
            state <= BYTE1;
        end
        BYTE2: begin
          state <= BYTE3;
        end
        BYTE3: begin
          state <= DONE;
        end
        DONE: begin
          if (in[2] == 1'b1)
            state <= BYTE2;
          else
            state <= BYTE1;
        end
        default: state <= BYTE1;
      endcase
    end
  end

  // Output logic
  always @(state) begin
    done = (state == DONE);
  end
  
endmodule
