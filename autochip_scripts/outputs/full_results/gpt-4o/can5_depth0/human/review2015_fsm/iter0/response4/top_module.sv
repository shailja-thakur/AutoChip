module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // State Encoding
    typedef enum logic [2:0] {
        S_IDLE,
        S_MATCH1,
        S_MATCH2,
        S_MATCH3,
        S_SHIFT,
        S_COUNT,
        S_DONE
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_count;
    
    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic
    always_comb begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (data) next_state = S_MATCH1;
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
            S_MATCH1: begin
                if (data) next_state = S_MATCH2;
                else next_state = S_IDLE;
            end
            S_MATCH2: begin
                if (~data) next_state = S_MATCH3;
                else next_state = S_IDLE;
            end
            S_MATCH3: begin
                if (data) next_state = S_SHIFT;
                else next_state = S_IDLE;
            end
            S_SHIFT: begin
                shift_ena = 1;
                if (shift_count == 4) begin
                    next_state = S_COUNT;
                    shift_ena = 0;
                end
            end
            S_COUNT: begin
                counting = 1;
                if (done_counting) next_state = S_DONE;
            end
            S_DONE: begin
                counting = 0;
                done = 1;
                if (ack) next_state = S_IDLE;
            end
        endcase
    end
    
    // Shift Counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 0;
        end else if (shift_ena) begin
            shift_count <= shift_count + 1;
        end else begin
            shift_count <= 0;
        end
    end
endmodule
