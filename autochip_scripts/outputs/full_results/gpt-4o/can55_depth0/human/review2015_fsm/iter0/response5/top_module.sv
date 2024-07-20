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
    typedef enum logic [3:0] {
        S_IDLE = 4'b0000,
        S_S1 = 4'b0001,
        S_S11 = 4'b0010,
        S_S110 = 4'b0011,
        S_SHIFT = 4'b0100,
        S_COUNT = 4'b0101,
        S_DONE = 4'b0110
    } state_t;
    
    state_t state, next_state;
    logic [1:0] bit_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            bit_count <= 2'b00;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 2'b00;
        end else if (state == S_SHIFT) begin
            if (bit_count == 2'b11) bit_count <= 2'b00;
            else bit_count <= bit_count + 1;
        end
    end

    always_comb begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            S_IDLE: begin
                if (data == 1) next_state = S_S1;
            end
            
            S_S1: begin
                if (data == 1) next_state = S_S11;
                else next_state = S_IDLE;
            end
            
            S_S11: begin
                if (data == 0) next_state = S_S110;
                else next_state = S_IDLE;
            end
            
            S_S110: begin
                if (data == 1) next_state = S_SHIFT;
                else next_state = S_IDLE;
            end
            
            S_SHIFT: begin
                shift_ena = 1;
                if (bit_count == 2'b11) next_state = S_COUNT;
            end
            
            S_COUNT: begin
                counting = 1;
                if (done_counting) next_state = S_DONE;
            end
            
            S_DONE: begin
                done = 1;
                if (ack) next_state = S_IDLE;
            end
            
            default: next_state = S_IDLE;
        endcase
    end

endmodule
