module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        READ_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;
    state_t state, next_state;
    
    reg [3:0] shift_reg;
    reg [1:0] bit_counter;
    reg [3:0] delay;
    reg [13:0] timer;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (bit_counter == 2'b11) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (timer == 14'd0) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // State output logic and data handling
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
            bit_counter <= 2'b0;
            delay <= 4'b0;
            timer <= 14'd0;
            count <= 4'bxxxx;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_reg <= 4'b0;
                    bit_counter <= 2'b0;
                    delay <= 4'b0;
                    timer <= 14'd0;
                    count <= 4'bxxxx;
                    counting <= 0;
                    done <= 0;
                end
                PATTERN_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                READ_DELAY: begin
                    bit_counter <= bit_counter + 1;
                    delay <= {delay[2:0], data};
                    if (bit_counter == 2'b11) begin
                        timer <= (delay + 1) * 1000;
                        count <= delay;
                        counting <= 1;
                    end
                end
                COUNTING: begin
                    if (timer > 0) begin
                        timer <= timer - 1;
                        if (timer % 1000 == 0) begin
                            count <= count - 1;
                        end
                    end if (timer == 0) begin
                        counting <= 0;
                        done <= 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
