module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [6:0] state;
    reg [3:0] timer_count;
    reg [2:0] remaining_time;

    // Detecting input pattern 1101
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            count <= 4'b0;
            delay <= 4'b0;
            timer_count <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                0: begin
                    if (data) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data) begin
                        state <= 4;
                    end else begin
                        state <= 0;
                    end
                end
                4: begin
                    state <= 5;
                    timer_count <= delay;
                    counting <= 1;
                    remaining_time <= delay;
                end
                5: begin
                    if (timer_count == 0) begin
                        counting <= 0;
                        done <= 1;
                        if (ack) begin
                            state <= 0;
                            counting <= 0;
                            done <= 0;
                            count <= 4'b0;
                            delay <= 4'b0;
                            timer_count <= 0;
                            remaining_time <= 0;
                        end
                    end else if (counting) begin
                        timer_count <= timer_count - 1;
                        if (timer_count % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                end
                default: begin
                    state <= 0;
                end
            endcase
        end
    end

    // Shifting in 4 more bits for delay determination
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
        end else begin
            if (state >= 1 && state <= 4) begin
                count <= {count[2:0], data};
                delay <= count;
            end
        end
    end

endmodule
