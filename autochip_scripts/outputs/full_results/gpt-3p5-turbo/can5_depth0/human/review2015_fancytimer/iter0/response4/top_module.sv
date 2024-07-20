module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;
    reg start_sequence_detected;
    reg [10:0] counter;
    reg [3:0] remaining_time;
  
    always @(posedge clk) begin
    
        if (reset) begin
            state <= 0;
            delay <= 0;
            counting <= 0;
            done <= 0;
            start_sequence_detected <= 0;
            count <= 0;
            counter <= 0;
            remaining_time <= 0;
        end
        else begin
            case(state)
                0: begin  // Searching for start sequence (1101)
                    if (data == 4'b1101) begin
                        start_sequence_detected <= 1;
                        state <= 1;
                    end
                    else begin
                        start_sequence_detected <= 0;
                        state <= 0;
                    end
                end
                1: begin  // Shifting in delay[3:0]
                    delay <= {delay[2:0], data};
                    counting <= 1;
                    state <= 2;
                end
                2: begin  // Counting for (delay[3:0] + 1) * 1000 cycles
                    if (counter < (delay + 1) * 1000) begin
                        counter <= counter + 1;
                        remaining_time <= delay;
                    end
                    else begin
                        counter <= 0;
                        remaining_time <= 0;
                        counting <= 0;
                        done <= 1;
                        state <= 3;
                    end
                end
                3: begin  // Waiting for ack
                    if (ack) begin
                        done <= 0;
                        state <= 0;
                    end
                    else begin
                        done <= 1;
                        state <= 3;
                    end
                end
            endcase
        end
    end
endmodule
