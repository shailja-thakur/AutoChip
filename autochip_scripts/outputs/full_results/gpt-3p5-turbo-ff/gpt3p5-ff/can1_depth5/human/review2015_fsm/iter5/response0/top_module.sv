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
    
    reg [3:0] state;
    reg [3:0] next_state;
    reg [3:0] shift_ena_count;

    parameter START = 0;
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_ENA = 2;
    parameter WAIT_COUNTING = 3;
    parameter TIMEOUT = 4;
    parameter WAIT_ACK = 5;

    always @(posedge clk) begin
        if (reset)
            state <= START;
        else
            state <= next_state;
    end

    always @(state or data or done_counting or ack) begin
        case (state)
            START: begin
                if (data == 4'b1101)
                    next_state = DETECT_PATTERN;
                else
                    next_state = START;
            end
            DETECT_PATTERN: begin
                next_state = SHIFT_ENA;
            end
            SHIFT_ENA: begin
                if (shift_ena_count == 3)
                    next_state = WAIT_COUNTING;
                else
                    next_state = SHIFT_ENA;
            end
            WAIT_COUNTING: begin
                if (done_counting)
                    next_state = TIMEOUT;
                else
                    next_state = WAIT_COUNTING;
            end
            TIMEOUT: begin
                next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = START;
                else
                    next_state = WAIT_ACK;
            end
            default: begin
                next_state = START;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            shift_ena_count <= 0;
        else if (state == SHIFT_ENA)
            shift_ena_count <= shift_ena_count + 1;
        else
            shift_ena_count <= 0;
    end

    always @(posedge clk) begin
        case (state)
            START: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_ENA: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            TIMEOUT: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            WAIT_ACK: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            default: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end

endmodule
