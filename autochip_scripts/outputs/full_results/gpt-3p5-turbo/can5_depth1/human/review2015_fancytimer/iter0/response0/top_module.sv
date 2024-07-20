module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] timer;
  reg [3:0] remaining;
  reg [3:0] state;
  reg found_sequence;
  
  parameter START = 4'b1101;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      count <= 4'b0000;
      counting <= 0;
      done <= 0;
      remaining <= 4'b0000;
      found_sequence <= 0;
    end
    else begin
      case (state)
        4'b0000: begin // Searching for start sequence
          if (data == START) begin
            state <= 4'b0001;
            found_sequence <= 1;
            remaining <= delay;
          end
        end
        4'b0001: begin // Shifting in delay bits
          delay <= {data, delay[3:1]};
          state <= 4'b0010;
        end
        4'b0010: begin // Start counting
          counting <= 1;
          state <= 4'b0011;
        end
        4'b0011: begin // Counting
          count <= remaining;
          if (count == 0) begin
            counting <= 0;
            done <= 1;
            state <= 4'b0100;
          end
          else begin
            remaining <= remaining - 1;
          end
        end
        4'b0100: begin // Wait for ack before resetting
          if (ack) begin
            state <= 4'b0000;
            done <= 0;
          end
        end
      endcase
    end
  end

endmodule
