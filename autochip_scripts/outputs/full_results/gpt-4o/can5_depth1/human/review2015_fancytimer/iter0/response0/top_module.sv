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
        IDLE       = 3'b000,
        RECOGNIZE  = 3'b001,
        DELAY_LOAD = 3'b010,
        COUNTING   = 3'b011,
        DONE_WAIT  = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [15:0] cycle_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            delay <= 4'b0;
            cycle_counter <= 16'b0;
            count <= 4'bxxxx;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (state == RECOGNIZE) begin
            shift_reg <= {shift_reg[2:0], data};
        end else if (state == DELAY_LOAD) begin
            shift_reg <= {shift_reg[2:0], data};
            if (shift_reg == 4'b1101) begin
                delay <= {shift_reg[2:0], data};
            end
        end
    end

    always_ff @(posedge clk) begin
        if (state == COUNTING) begin
            if (cycle_counter < 1000) begin
                cycle_counter <= cycle_counter + 1;
            end else begin
                cycle_counter <= 0;
                if (delay != 0) begin
                    delay <= delay - 1;
                end else begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
        end else begin
            cycle_counter <= 0;
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                count = 4'bxxxx;
                counting = 1'b0;
                done = 1'b0;
                if (data) begin
                    next_state = RECOGNIZE;
                end
            end
            RECOGNIZE: begin
                count = 4'bxxxx;
                if (shift_reg == 4'b1101) begin
                    next_state = DELAY_LOAD;
                end
            end
            DELAY_LOAD: begin
                count = 4'bxxxx;
                if (shift_reg == 4'b1101) begin
                    if (delay == 4'bxxxx) begin
                        delay <= {shift_reg[2:0], data};
                        next_state = COUNTING;
                    end
                end
            end
            COUNTING: begin
                counting = 1'b1;
                count = delay;
                if (delay == 0 && cycle_counter == 1000) begin
                    next_state = DONE_WAIT;
                end
            end
            DONE_WAIT: begin
                counting = 1'b0;
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
