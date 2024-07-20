module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [2:0] state, next_state;
    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [12:0] timer; // to count up to (delay + 1) * 1000 cycles

    localparam IDLE = 3'b000,
               DETECT_PATTERN = 3'b001,
               LOAD_DELAY = 3'b010,
               COUNT = 3'b011,
               DONE = 3'b100;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset) begin
            pattern_shift <= 4'b0000;
            delay <= 4'b0000;
            timer <= 13'd0;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    pattern_shift <= 4'b0000;
                    delay <= 4'b0000;
                    timer <= 13'd0;
                    count <= 4'b0000;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                DETECT_PATTERN: begin
                    pattern_shift <= {pattern_shift[2:0], data};
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                end
                COUNT: begin
                    if (timer == 13'd999) begin
                        if (count == 4'd0) begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end 
                        else begin
                            count <= count - 4'd1;
                            timer <= 13'd0;
                        end
                    end 
                    else begin
                        timer <= timer + 13'd1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case(state)
            IDLE: begin
                if (pattern_shift == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = DETECT_PATTERN;
            end
            DETECT_PATTERN: begin
                if (pattern_shift == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = DETECT_PATTERN;
            end
            LOAD_DELAY: begin
                if (delay[3]) begin
                    count = delay;
                    counting = 1'b1;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done) begin
                    next_state = DONE;
                end 
                else if (timer == 13'd999) begin
                    if (count == 4'd0) begin
                        next_state = DONE;
                    end
                    else begin
                        count = count - 4'd1;
                    end
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
