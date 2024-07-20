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

    // State definitions using localparams for easier readability
    localparam IDLE = 3'd0;
    localparam CHECK_PATTERN_1 = 3'd1;
    localparam CHECK_PATTERN_2 = 3'd2;
    localparam CHECK_PATTERN_3 = 3'd3;
    localparam CHECK_PATTERN_4 = 3'd4;
    localparam SHIFT = 3'd5;
    localparam COUNT = 3'd6;
    localparam DONE = 3'd7;
    
    reg [2:0] state, next_state;
    reg [1:0] shift_counter;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic combined
    always @(*) begin
        // Default output values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        next_state = state; // Default to hold state

        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = CHECK_PATTERN_1;
            end
            
            CHECK_PATTERN_1: begin
                if (data == 1)
                    next_state = CHECK_PATTERN_2;
                else
                    next_state = IDLE;
            end
            
            CHECK_PATTERN_2: begin
                if (data == 0)
                    next_state = CHECK_PATTERN_3;
                else
                    next_state = IDLE;
            end
            
            CHECK_PATTERN_3: begin
                if (data == 1)
                    next_state = CHECK_PATTERN_4;
                else
                    next_state = IDLE;
            end
            
            CHECK_PATTERN_4: begin
                if (data == 1) begin
                    next_state = SHIFT;
                    shift_counter = 2'd0;  // Initialize shift counter
                end
                else
                    next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'd3)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end

            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end

            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 2'd0;
        else if (state == SHIFT)
            shift_counter <= shift_counter + 1;
    end

endmodule
