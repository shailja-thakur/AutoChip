module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        PATTERN_DETECT = 3'd1,
        LOAD_DELAY = 3'd2,
        COUNTING = 3'd3,
        DONE = 3'd4
    } state_t;
    
    state_t state, next_state;
    
    // Internal signals
    reg [3:0] shift_reg;
    reg [3:0] delay, remaining_time;
    reg [12:0] cycle_count;

    // Sequential state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine logic
    always @* begin
        next_state = state;
        
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            
            LOAD_DELAY: begin
                next_state = COUNTING;
            end
            
            COUNTING: begin
                if (cycle_count == 13'd999) begin
                    if (remaining_time == 4'd0) begin
                        next_state = DONE;
                    end else begin
                        remaining_time = remaining_time - 4'd1;
                        cycle_count = 13'd0;
                    end
                end
            end
            
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Shift register logic to detect patterns and load delay
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'd0;
            delay <= 4'd0;
            cycle_count <= 13'd0;
            remaining_time <= 4'd0;
        end else if (state == PATTERN_DETECT || state == LOAD_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
            if (state == LOAD_DELAY) begin
                delay <= {shift_reg[2:0], data};
                remaining_time <= {shift_reg[2:0], data};
            end
        end else if (state == COUNTING) begin
            if (cycle_count == 13'd999) begin
                cycle_count <= 13'd0;
            end else begin
                cycle_count <= cycle_count + 13'd1;
            end
        end
    end

    // Output assignments
    assign count = remaining_time;
    
    // Counting output logic
    always @(state or cycle_count) begin
        if (state == COUNTING) begin
            counting = 1'b1;
        end else begin
            counting = 1'b0;
        end
    end

endmodule
