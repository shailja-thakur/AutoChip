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
    reg [3:0] remaining_time;
    reg start_sequence_detected;
    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            start_sequence_detected <= 0;
            state <= 0;
            delay <= 0;
            counting <= 0;
            done <= 0;
            timer <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                0: if (data == 1) begin
                      start_sequence_detected <= 1;
                      state <= 1;
                  end else begin
                      start_sequence_detected <= 0;
                      state <= 0;
                  end
                1: if (data == 1) begin
                      delay <= {data, delay[3:1]};
                      state <= 2;
                  end else begin
                      start_sequence_detected <= 0;
                      state <= 0;
                  end
                2: if (counting) begin
                      state <= 2;
                  end else begin
                      state <= 3;
                      counting <= 1;
                      timer <= (delay + 1) * 1000;
                      remaining_time <= delay;
                  end
                3: begin
                      if (timer > 0) begin
                          timer <= timer - 1;
                          if ((timer % 1000) == 0) begin
                              remaining_time <= remaining_time - 1;
                          end
                      end else begin
                          counting <= 0;
                          done <= 1;
                          state <= 4;
                      end
                  end
                4: if (ack) begin
                      done <= 0;
                      state <= 0;
                  end else begin
                      state <= 4;
                  end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bXXXX;

endmodule
