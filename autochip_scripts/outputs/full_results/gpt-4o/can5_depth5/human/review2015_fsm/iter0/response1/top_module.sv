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
        S_RESET        = 3'b000,
        S_SEARCH_1     = 3'b001,
        S_SEARCH_11    = 3'b010,
        S_SEARCH_110   = 3'b011,
        S_SEARCH_1101  = 3'b100,
        S_SHIFT        = 3'b101,
        S_COUNT        = 3'b110,
        S_DONE         = 3'b111
    } state_t;
    
    // State variables
    state_t state, next_state;
    integer shift_count;
    
    // State transition logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            S_RESET: begin
                next_state = S_SEARCH_1;
            end
            S_SEARCH_1: begin
                if(data)
                    next_state = S_SEARCH_11;
                else
                    next_state = S_SEARCH_1;
            end
            S_SEARCH_11: begin
                if(data)
                    next_state = S_SEARCH_110;
                else
                    next_state = S_SEARCH_1;
            end
            S_SEARCH_110: begin
                if(!data)
                    next_state = S_SEARCH_1101;
                else
                    next_state = S_SEARCH_1;
            end
            S_SEARCH_1101: begin
                if(data)
                    next_state = S_SHIFT;
                else
                    next_state = S_SEARCH_1;
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if(shift_count == 4)
                    next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1'b1;
                if(done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1'b1;
                if(ack)
                    next_state = S_SEARCH_1;
            end
            default: begin
                next_state = S_RESET;
            end
        endcase
    end
    
    // State and counter update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_RESET;
            shift_count <= 0;
        end
        else begin
            state <= next_state;
            if (state == S_SHIFT)
                shift_count <= shift_count + 1;
            else
                shift_count <= 0;
        end
    end
    
endmodule
