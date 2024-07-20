module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );
  
  reg [2:0] state;
  reg [3:0] delay;
  reg [3:0] counter;
  reg [3:0] remaining;
  reg start_sequence_found;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      delay <= 0;
      counter <= 0;
      remaining <= 0;
      start_sequence_found <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin // Searching for start sequence
          if (data == 1'b1) begin
            state <= 1;
            start_sequence_found <= 1;
          end else begin
            state <= 0;
          end
        end
        1: begin // Start sequence found, reading delay bits
          delay <= {delay[2:0], data};
          state <= 2;
        end
        2: begin // Start counting
          if (counter == (delay + 1) * 1000) begin
            counting <= 0;
            done <= 1;
            state <= 3;
          end else begin
            counter <= counter + 1;
            counting <= 1;
            state <= 2;
          end
        end
        3: begin // Waiting for ack
          if (ack) begin
            state <= 0;
            start_sequence_found <= 0;
            done <= 0;
          end else begin
            state <= 3;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (!reset && done) begin
      remaining <= delay;
    end else begin
      remaining <= (done) ? remaining - 1 : remaining;
    end
  end
  
  assign count = counting ? remaining : 4'b0;

endmodule
