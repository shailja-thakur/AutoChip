module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0, 
        ON = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
        endcase
    end

endmodule
