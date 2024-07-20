module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'd0,
        ON  = 2'd1
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            OFF: begin
                if (j == 1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF; // Default state should be OFF
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
