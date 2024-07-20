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

    // State encoding
    typedef enum logic [2:0] {
        S_IDLE        = 3'b000,
        S_SHIFT       = 3'b001,
        S_COUNT       = 3'b010,
        S_DONE        = 3'b011
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_counter;

    // Pattern detection variables
    reg [3:0] pattern_shift_reg;
    wire pattern_detected;

    // Shift register to detect 1101 pattern
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0;
        end else begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end

    assign pattern_detected = (pattern_shift_reg == 4'b1101);

    // FSM state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM next state logic and outputs
    always @(*) begin
        // Default values for outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        next_state = state;
        case (state)
            S_IDLE: begin
                if (pattern_detected) begin
                    next_state = S_SHIFT;
                end
            end
            
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 4'd4) begin
                    next_state = S_COUNT;
                end
            end
            
            S_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = S_DONE;
                end
            end

            S_DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = S_IDLE;
                end
            end
            
            default: next_state = S_IDLE;
        endcase
    end

    // Shift counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 4'b0;
        end else if (state == S_SHIFT) begin
            if (shift_counter < 4'd4) begin
                shift_counter <= shift_counter + 1;
            end
        end else begin
            shift_counter <= 4'b0;
        end
    end

endmodule
