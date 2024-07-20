module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    parameter IDLE = 3'b000,
              PATTERN_DETECT = 3'b001,
              LOAD_DELAY = 3'b010,
              COUNT = 3'b011,
              DONE = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] shift_reg, delay_reg, count_reg;
    reg [12:0] cycle_counter; // To count up to 8000 cycles

    wire pattern_detected = (shift_reg == 4'b1101);
    assign count = count_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            delay_reg <= 4'b0;
            count_reg <= 4'b0;
            cycle_counter <= 13'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == PATTERN_DETECT) begin
                shift_reg <= {shift_reg[2:0], data};
            end else if (state == LOAD_DELAY) begin
                shift_reg <= {shift_reg[2:0], data};
                if (cycle_counter == 13) begin
                    cycle_counter <= 0;
                    delay_reg <= shift_reg[2:0];
                    count_reg <= shift_reg[3:0];
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end else if (state == COUNT) begin
                if (cycle_counter == 1000) begin
                    cycle_counter <= 0;
                    if (count_reg > 0) begin
                        count_reg <= count_reg - 1;
                    end else begin
                        done <= 1'b1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                shift_reg = 4'b0;
                if (pattern_detected)
                    next_state = PATTERN_DETECT;
            end
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (cycle_counter == 13)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done)
                    next_state = DONE;
            end
            DONE: begin
                counting = 1'b0;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
