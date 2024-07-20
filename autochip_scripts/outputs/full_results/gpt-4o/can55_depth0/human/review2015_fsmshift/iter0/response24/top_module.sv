module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // State Encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        SHIFT1 = 2'b01,
        SHIFT2 = 2'b10,
        SHIFT3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    integer count;
    
    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end else begin
            state <= next_state;
            if (shift_ena)
                count <= count + 1;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = SHIFT1;
                else
                    next_state = IDLE;
            end
            
            SHIFT1: begin
                if (count == 1)
                    next_state = SHIFT2;
                else
                    next_state = SHIFT1;
            end
            
            SHIFT2: begin
                if (count == 2)
                    next_state = SHIFT3;
                else
                    next_state = SHIFT2;
            end
            
            SHIFT3: begin
                if (count == 3)
                    next_state = IDLE;
                else
                    next_state = SHIFT3;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1;
        else if (state == SHIFT3 && count == 3)
            shift_ena <= 0;
        else if (state != IDLE)
            shift_ena <= 1;
        else
            shift_ena <= 0;
    end

endmodule
