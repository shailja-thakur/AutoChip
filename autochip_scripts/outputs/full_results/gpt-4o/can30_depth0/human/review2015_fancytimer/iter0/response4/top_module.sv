module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state, next_state;
    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [13:0] counter;  // 14-bit counter to count up to 10000 cycles

    localparam IDLE = 4'd0, // State IDs
               DETECT_1 = 4'd1,
               DETECT_11 = 4'd2,
               DETECT_110 = 4'd3,
               DETECT_1101 = 4'd4,
               READ_DELAY = 4'd5,
               COUNT = 4'd6,
               DONE = 4'd7;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'd0;
            delay <= 4'd0;
            counter <= 14'd0;
            count <= 4'd0;
            counting <= 1'd0;
            done <= 1'd0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                pattern_shift = 4'd0;
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                if (data) begin
                    pattern_shift = 4'd1;
                    next_state = READ_DELAY;
                end else
                    next_state = IDLE;
            end
            READ_DELAY: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift[3]) begin
                    delay = pattern_shift;
                    count = delay;
                    counter = 14'd0;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (counter < ((delay + 1) * 1000 - 1)) begin
                    counter = counter + 1;
                    if (counter % 1000 == 0)
                        count = count - 1;
                end else begin
                    next_state = DONE;
                end 
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end 
            end
        endcase
    end
endmodule
