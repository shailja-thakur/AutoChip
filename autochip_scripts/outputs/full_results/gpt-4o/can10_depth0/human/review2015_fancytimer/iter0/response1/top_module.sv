module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State definitions
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;

    // Other necessary variables
    reg [3:0] delay;
    reg [15:0] counter;
    reg [2:0] bit_counter;
    reg [3:0] shift_reg;
    reg [3:0] delay_buffer;

    // State machine logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            IDLE: next_state = PATTERN_DETECT;
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end
            LOAD_DELAY: begin
                if (bit_counter == 3) begin
                    next_state = COUNTING;
                end else begin
                    next_state = LOAD_DELAY;
                end
            end
            COUNTING: begin
                if (counter == 0) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // FSM output and counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
            counter <= 16'b0;
            delay <= 4'd0;
            shift_reg <= 4'b0;
            bit_counter <= 3'd0;
            delay_buffer <= 4'd0;
        end else begin
            case (next_state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    count <= 4'd0;
                    counter <= 16'b0;
                    delay <= 4'd0;
                    shift_reg <= 4'b0;
                    bit_counter <= 3'd0;
                    delay_buffer <= 4'd0;
                end
                PATTERN_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                LOAD_DELAY: begin
                    delay_buffer <= {delay_buffer[2:0], data};
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 3) begin
                        delay <= {delay_buffer[2:0], data};
                    end
                end
                COUNTING: begin
                    counting <= 1'b1;
                    counter <= counter + 1;
                    if (counter == 1000) begin
                        counter <= 0;
                        count <= count - 1;
                        if (count == 0) begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
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

    always_comb begin
        if (state == COUNTING) begin
            count = delay;
            for (integer i = 0; i < 4; i = i + 1) begin
                if (counter < (i + 1) * 1000) begin
                    count = delay - i;
                    break;
                end
            end
        end
    end
endmodule
