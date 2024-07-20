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

localparam IDLE = 3'b000;
localparam DETECT_PATTERN = 3'b001;
localparam SHIFT_DURATION = 3'b010;
localparam WAIT_COUNTING = 3'b011;
localparam NOTIFY_USER = 3'b100;

reg [2:0] current_state, next_state;
reg [3:0] pattern_shift_reg;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        pattern_shift_reg <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        current_state <= next_state;
        case (current_state)
            IDLE: begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state <= DETECT_PATTERN;
                end else begin
                    next_state <= IDLE;
                end
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
            DETECT_PATTERN: begin
                next_state <= SHIFT_DURATION;
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            SHIFT_DURATION: begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg[3:0] == 4'b0000) begin
                    next_state <= WAIT_COUNTING;
                end else begin
                    next_state <= SHIFT_DURATION;
                end
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            WAIT_COUNTING: begin
                next_state <= NOTIFY_USER;
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            NOTIFY_USER: begin
                if (done_counting) begin
                    next_state <= IDLE;
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                end else begin
                    next_state <= NOTIFY_USER;
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b1;
                end
                if (ack) begin
                    next_state <= IDLE;
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            end
            default: begin
                next_state <= IDLE;
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
