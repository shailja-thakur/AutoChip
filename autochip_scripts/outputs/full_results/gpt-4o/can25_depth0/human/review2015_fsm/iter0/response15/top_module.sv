module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state, next_state;
    reg [3:0] pattern_shifter;

    // State definitions
    localparam WAIT_PATTERN = 3'b000,
               SHIFT_BITS   = 3'b001,
               COUNT        = 3'b010,
               WAIT_ACK     = 3'b011;
    
    // Sequential block for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_PATTERN;
        end else begin
            state <= next_state;
        end
    end

    // Sequential block for pattern shifter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shifter <= 4'b0000;
        end else if (state == WAIT_PATTERN) begin
            pattern_shifter <= {pattern_shifter[2:0], data};
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            WAIT_PATTERN: begin
                if (pattern_shifter == 4'b1101) begin
                    next_state = SHIFT_BITS;
                end
            end
            
            SHIFT_BITS: begin
                shift_ena = 1'b1;
                if (pattern_shifter == 4'b0000) begin
                    next_state = COUNT;
                end
            end

            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            default: next_state = WAIT_PATTERN;
        endcase
    end

    // Sequential block for shift counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shifter <= 4'b0000;
        end else if (state == SHIFT_BITS) begin
            pattern_shifter <= pattern_shifter - 1;
        end
    end

endmodule
