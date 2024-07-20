module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State enumeration
    typedef enum reg [1:0] {
        S_START = 2'b00,
        S_ONE = 2'b01,
        S_ZERO = 2'b10,
        S_DONE = 2'b11
    } state_t;
    
    // State register
    reg state, next_state;
    
    // Flip-flop to hold the complement status
    reg complement;
    
    // Sequential state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_START;
            z <= 0;
            complement <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S_START: begin
                if (x == 1) begin
                    next_state = S_ONE;
                end else begin
                    next_state = S_ZERO;
                end
                z = 0;
                complement = 0;
            end
            
            S_ONE: begin
                next_state = S_DONE;
                z = ~x;
                complement = 1;
            end
            
            S_ZERO: begin
                next_state = S_DONE;
                z = ~x;
                complement = 1;
            end
            
            S_DONE: begin
                if (complement == 1) begin
                    z = ~x;
                end else begin
                    z = x;
                end
                next_state = S_DONE;
            end
            
            default: begin
                next_state = S_START;
            end
        endcase
    end
    
endmodule
