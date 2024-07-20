module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S_RESET    = 3'd0,
        S_ZERO     = 3'd1,
        S_ONE      = 3'd2,
        S_TWO_ONES = 3'd3,
        S_THREE_ONES = 3'd4,
        S_FOUR_ONES = 3'd5,
        S_FIVE_ONES = 3'd6,
        S_SIX_ONES = 3'd7,
        S_SEVEN_ONES = 3'd8
    } state_t;
    
    state_t current_state, next_state;
    
    always @(posedge clk) begin
        if (reset)
            current_state <= S_RESET;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = current_state;
        
        case (current_state)
            S_RESET: begin
                if (in)
                    next_state = S_ONE;
                else
                    next_state = S_ZERO;
            end
            
            S_ZERO: begin
                if (in)
                    next_state = S_ONE;
                else
                    next_state = S_ZERO;
            end
            
            S_ONE: begin
                if (in)
                    next_state = S_TWO_ONES;
                else
                    next_state = S_ZERO;
            end
            
            S_TWO_ONES: begin
                if (in)
                    next_state = S_THREE_ONES;
                else
                    next_state = S_ZERO;
            end
            
            S_THREE_ONES: begin
                if (in)
                    next_state = S_FOUR_ONES;
                else
                    next_state = S_ZERO;
            end
            
            S_FOUR_ONES: begin
                if (in)
                    next_state = S_FIVE_ONES;
                else
                    next_state = S_ZERO;
            end
            
            S_FIVE_ONES: begin
                if (in) begin
                    next_state = S_SIX_ONES;
                    disc = 1'b1;
                end else
                    next_state = S_ZERO;
            end
            
            S_SIX_ONES: begin
                if (in) begin
                    next_state = S_SEVEN_ONES;
                    err = 1'b1;
                end else begin
                    next_state = S_ZERO;
                    flag = 1'b1;
                end
            end
            
            S_SEVEN_ONES: begin
                if (in)
                    next_state = S_SEVEN_ONES;
                else
                    next_state = S_ZERO;
            end
            
            default: next_state = S_RESET;
        endcase
    end
endmodule
