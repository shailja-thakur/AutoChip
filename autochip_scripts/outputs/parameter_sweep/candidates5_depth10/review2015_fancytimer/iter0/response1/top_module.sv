module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] current_count;
    reg [3:0] remaining_time;
    reg [3:0] next_state;
    reg [3:0] state;

    parameter IDLE_STATE = 4'b0000;
    parameter DETECT_PATTERN = 4'b0001;
    parameter SHIFT_IN_DELAY = 4'b0010;
    parameter COUNT_DELAY = 4'b0011;
    parameter UPDATE_REMAINING_TIME = 4'b0100;
    parameter RESUME_SEARCH = 4'b0101;

    // state register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE_STATE;
        end else begin
            state <= next_state;
        end
    end

    // count register
    always @(posedge clk) begin
        if (counting) begin
            if (count_reg == 4'b0000) begin
                count_reg <= delay;
            end else begin
                count_reg <= count_reg - 1;
            end
        end
    end

    // current count register
    always @(posedge clk) begin
        if (state == COUNT_DELAY && counting) begin
            current_count <= count_reg;
        end else begin
            current_count <= 4'b0000;
        end
    end

    // remaining time register
    always @(posedge clk) begin
        if (state == UPDATE_REMAINING_TIME && counting) begin
            if (remaining_time == 4'b0000) begin
                remaining_time <= delay;
            end else begin
                remaining_time <= remaining_time - 1;
            end
        end else begin
            remaining_time <= 4'b0000;
        end
    end

    // next state logic
    always @(*) begin
        case (state)
            IDLE_STATE: begin
                if (data == 1'b1) begin
                    next_state = DETECT_PATTERN;
                end else begin
                    next_state = IDLE_STATE;
                end
            end

            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = SHIFT_IN_DELAY;
                end else begin
                    next_state = IDLE_STATE;
                end
            end

            SHIFT_IN_DELAY: begin
                next_state = COUNT_DELAY;
            end

            COUNT_DELAY: begin
                if (count_reg == 4'b0000) begin
                    next_state = UPDATE_REMAINING_TIME;
                end else begin
                    next_state = COUNT_DELAY;
                end
            end

            UPDATE_REMAINING_TIME: begin
                if (remaining_time == 4'b0000) begin
                    if (ack == 1'b1) begin
                        next_state = RESUME_SEARCH;
                    end else begin
                        next_state = UPDATE_REMAINING_TIME;
                    end
                end else begin
                    next_state = COUNT_DELAY;
                end
            end

            RESUME_SEARCH: begin
                if (data == 1'b1) begin
                    next_state = DETECT_PATTERN;
                end else begin
                    next_state = IDLE_STATE;
                end
            end
        endcase
    end

    // counting output
    always @(posedge clk) begin
        if (state == COUNT_DELAY) begin
            counting <= 1'b1;
        end else begin
            counting <= 1'b0;
        end
    end

    // done output
    always @(posedge clk) begin
        if (state == UPDATE_REMAINING_TIME && remaining_time == 4'b0000 && ack == 1'b1) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule
