module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: 
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
            A: 
                if (in == 0)
                    next_state = B;
                else
                    next_state = A;
            default: 
                next_state = B;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic of Moore Machine
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
