module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        SEARCH    = 3'b000,
        LOAD_BITS = 3'b001,
        DELAY_WAIT= 3'b010,
        DONE_WAIT = 3'b011
    } state_t;

    state_t state, next_state;
    reg [3:0] pattern_shift_reg;
    reg [3:0] delay;
    reg [12:0] cycle_counter;
    reg [2:0] pattern_counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SEARCH;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0;
            pattern_counter <= 3'b0;
            delay <= 4'b0;
            cycle_counter <= 13'b0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'b0;
        end else begin
            case (state)
                SEARCH: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                    if (pattern_shift_reg == 4'b1101)
                        pattern_counter <= 4;
                end
                LOAD_BITS: begin
                    if (pattern_counter > 0) begin
                        pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                        pattern_counter <= pattern_counter - 1;
                        if (pattern_counter == 1)
                            delay <= pattern_shift_reg;
                    end
                end
                DELAY_WAIT: begin
                    counting <= (cycle_counter < (delay + 1) * 1000);
                    count <= (cycle_counter / 1000);
                    cycle_counter <= cycle_counter + 1;
                    if (cycle_counter >= (delay + 1) * 1000) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE_WAIT: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= SEARCH;
                    end
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            SEARCH: if (pattern_shift_reg == 4'b1101) next_state = LOAD_BITS;
            LOAD_BITS: if (pattern_counter == 1 && delay != 0) next_state = DELAY_WAIT;
            DELAY_WAIT: if (cycle_counter >= (delay + 1) * 1000) next_state = DONE_WAIT;
            DONE_WAIT: if (ack) next_state = SEARCH;
        endcase
    end

endmodule
