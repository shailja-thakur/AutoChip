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

localparam [2:0] WAIT_FOR_START = 3'b000,
                 SHIFT_DURATION = 3'b001,
                 WAIT_FOR_DONE  = 3'b010,
                 NOTIFY_USER    = 3'b011;

reg [2:0] state, next_state;
reg [3:0] pattern_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        pattern_reg <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        pattern_reg <= {pattern_reg[2:0], data};
        
        case (state)
            WAIT_FOR_START: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                if (pattern_reg == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    next_state <= WAIT_FOR_START;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
                if (pattern_reg[3:0] == 4'b1111) begin
                    next_state <= WAIT_FOR_DONE;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
            end
            WAIT_FOR_DONE: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                end
                else begin
                    next_state <= WAIT_FOR_DONE;
                end
            end
            NOTIFY_USER: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
                if (ack) begin
                    next_state <= WAIT_FOR_START;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
            end
            default: begin
                next_state <= WAIT_FOR_START;
            end
        endcase
    end
end

endmodule
