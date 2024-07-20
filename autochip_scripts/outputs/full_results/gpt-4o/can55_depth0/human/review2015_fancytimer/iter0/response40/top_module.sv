module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// State encoding
typedef enum reg [2:0] {
    IDLE = 3'd0,
    PATTERN_DETECT = 3'd1,
    SHIFT_IN_DELAY = 3'd2,
    COUNT = 3'd3,
    DONE = 3'd4
} state_t;

state_t current_state, next_state;

// Registers for detecting pattern 1101
reg [3:0] shift_reg;
reg [3:0] delay;
reg [13:0] counter; // To count up to 16000 cycles

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        shift_reg <= 4'd0;
        delay <= 4'd0;
        counter <= 14'd0;
        counting <= 1'b0;
        done <= 1'b0;
        count <= 4'd0;
    end
    else begin
        current_state <= next_state;

        case(current_state)
            IDLE: begin
                shift_reg <= 4'd0;
                delay <= 4'd0;
                counter <= 14'd0;
                counting <= 1'b0;
                done <= 1'b0;
                count <= 4'd0;
            end

            PATTERN_DETECT: begin
                shift_reg <= {shift_reg[2:0], data};
            end

            SHIFT_IN_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                delay <= shift_reg;
            end

            COUNT: begin
                counting <= 1'b1;

                if (counter == ((delay + 4'd1) * 1000) - 1) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    counter <= counter + 14'd1;
                    count <= (counter / 1000) ? count : delay - (counter / 1000);
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
    case(current_state)
        IDLE: begin
            if (shift_reg == 4'b1101)
                next_state = SHIFT_IN_DELAY;
            else
                next_state = PATTERN_DETECT;
        end

        PATTERN_DETECT: begin
            if (shift_reg == 4'b1101)
                next_state = SHIFT_IN_DELAY;
            else
                next_state = PATTERN_DETECT;
        end

        SHIFT_IN_DELAY: begin
            next_state = COUNT;
        end

        COUNT: begin
            if (done)
                next_state = DONE;
            else
                next_state = COUNT;
        end

        DONE: begin
            if (ack)
                next_state = IDLE;
            else
                next_state = DONE;
        end

        default: next_state = IDLE;
    endcase
end

endmodule
