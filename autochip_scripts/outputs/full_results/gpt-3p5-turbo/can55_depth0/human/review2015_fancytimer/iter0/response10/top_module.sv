module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining_time;
    reg [2:0] state;
    reg start_sequence_detected;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            start_sequence_detected <= 0;
        end else begin
            case (state)
                0: begin
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        start_sequence_detected <= 1;
                        delay <= data;
                        state <= 1;
                    end else begin
                        start_sequence_detected <= 0;
                        state <= 0;
                    end
                end
                1: begin
                    counting <= 0;
                    done <= 0;
                    start_sequence_detected <= 0;
                    state <= 2;
                end
                2: begin
                    counting <= 1;
                    done <= 0;
                    counter <= 4'b0;
                    remaining_time <= delay;
                    state <= 3;
                end
                3: begin
                    counting <= 1;
                    done <= 0;
                    start_sequence_detected <= 0;
                    if (counter == (delay + 1)) begin
                        counting <= 0;
                        done <= 1;
                        state <= 4;
                    end else begin
                        counter <= counter + 1;
                        if (counter == 4'b1111) begin
                            remaining_time <= remaining_time - 1;
                            counter <= 4'b0;
                        end
                    end
                end
                4: begin
                    counting <= 0;
                    done <= 0;
                    if (ack) begin
                        state <= 0;
                    end else begin
                        state <= 4;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    assign count = remaining_time;

endmodule
