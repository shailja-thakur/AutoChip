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
    typedef enum logic [2:0] {
        IDLE,       // Waiting for 1101 pattern
        SHIFT,      // Shifting in delay bits
        COUNTING,   // Timer counting down
        DONE        // Timer has finished counting
    } state_t;
    state_t state, next_state;

    reg [3:0] delay;
    reg [9:0] count_down;
    reg [3:0] shift_reg;
    reg [2:0] bit_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            bit_counter <= 0;
            delay <= 0;
            shift_reg <= 0;
            count_down <= 0;
            counting <= 0;
            done <= 0;
            count <= 4'bx;
        end else begin
            case (state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        next_state <= SHIFT;
                        bit_counter <= 3;
                    end
                end
                SHIFT: begin
                    shift_reg <= {shift_reg[2:0], data};
                    bit_counter <= bit_counter - 1;
                    if (bit_counter == 0) begin
                        delay <= {shift_reg[2:0], data};
                        next_state <= COUNTING;
                        count_down <= ({shift_reg[2:0], data} + 1) * 1000 - 1;
                        count <= shift_reg[2:0] + 1;
                    end
                end
                COUNTING: begin
                    if (count_down == 0) begin
                        next_state <= DONE;
                    end else begin
                        count_down <= count_down - 1;
                        if (count_down % 1000 == 0) count <= count - 1;
                    end
                end
                DONE: begin
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    always_comb begin
        counting = (state == COUNTING);
        case (state)
            IDLE: next_state = IDLE;
            SHIFT: next_state = SHIFT;
            COUNTING: next_state = COUNTING;
            DONE: next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

endmodule
