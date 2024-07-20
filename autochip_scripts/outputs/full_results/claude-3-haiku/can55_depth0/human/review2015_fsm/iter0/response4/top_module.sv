module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

// Define the states
localparam [2:0] 
    IDLE = 3'b000,
    DETECT_PATTERN = 3'b001,
    SHIFT_DURATION = 3'b010,
    WAIT_COUNTING = 3'b011,
    NOTIFY_DONE = 3'b100;

reg [2:0] current_state, next_state;
reg [3:0] pattern_shift_reg;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        IDLE: begin
            if (pattern_shift_reg == 4'b1101) begin
                next_state = DETECT_PATTERN;
            end
        end
        DETECT_PATTERN: begin
            next_state = SHIFT_DURATION;
        end
        SHIFT_DURATION: begin
            if (shift_ena == 1'b1 && pattern_shift_reg[0] == 1'b0) begin
                next_state = WAIT_COUNTING;
            end
        end
        WAIT_COUNTING: begin
            if (done_counting == 1'b1) begin
                next_state = NOTIFY_DONE;
            end
        end
        NOTIFY_DONE: begin
            if (ack == 1'b1) begin
                next_state = IDLE;
            end
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        pattern_shift_reg <= 4'b0;
    end
    else begin
        case (current_state)
            IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            DETECT_PATTERN: begin
                shift_ena <= 1'b1;
            end
            SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            WAIT_COUNTING: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
            end
            NOTIFY_DONE: begin
                counting <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
