module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declarations
    typedef enum reg [2:0] {
        S_IDLE,
        S_SHIFT,
        S_COUNT,
        S_DONE,
        S_WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            bit_count <= 3'd0;
        end
        else begin
            state <= next_state;
            if (state == S_SHIFT) begin
                bit_count <= bit_count + 1;
            end
            else if (state == S_IDLE || state == S_DONE) begin
                bit_count <= 3'd0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            S_IDLE: begin
                if (data == 1'b1) begin
                    next_state = S_SHIFT;
                end
            end
            
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (bit_count == 3'd3) begin
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
endmodule
