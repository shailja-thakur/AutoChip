module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        S1         = 3'b001,
        S11        = 3'b010,
        S110       = 3'b011,
        S1101      = 3'b100
    } state_t;
    
    state_t current_state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            S1101: begin
                next_state = S1101;
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Output Logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S1101)
            start_shifting <= 1;
    end
    
endmodule
