module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        OFF_STATE = 2'b00,
        ON_STATE = 2'b01
    } state_t;
    
    state_t current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF_STATE: begin
                if (j)
                    next_state = ON_STATE;
                else
                    next_state = OFF_STATE;
            end
            ON_STATE: begin
                if (k)
                    next_state = OFF_STATE;
                else
                    next_state = ON_STATE;
            end
            default: next_state = OFF_STATE;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= OFF_STATE;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else if (current_state == OFF_STATE)
            out <= 1'b0;
        else
            out <= 1'b1;
    end
endmodule
