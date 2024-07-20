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
    reg [2:0] pattern;
    reg [1:0] shift_count;
    
    // State encoding
    localparam IDLE      = 3'd0,
               PATTERN   = 3'd1,
               SHIFT     = 3'd2,
               COUNT     = 3'd3,
               DONE      = 3'd4;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if ({pattern[2:0], data} == 4'b1101)
                    next_state = PATTERN;
            end

            PATTERN: begin
                shift_ena = 1'b1;
                next_state = SHIFT;
                shift_count = 2'd0;
            end

            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 2'd3)
                    next_state = COUNT;
                else
                    shift_count = shift_count + 1;
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
        endcase
    end

    // Pattern register
    always @(posedge clk or posedge reset) begin
        if (reset)
            pattern <= 3'd0;
        else if (state == IDLE || state == PATTERN)
            pattern <= {pattern[1:0], data};
    end
    
    // Shift counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_count <= 2'd0;
        else if (state == SHIFT)
            shift_count <= shift_count + 1;
        else
            shift_count <= 2'd0;
    end
    
endmodule
