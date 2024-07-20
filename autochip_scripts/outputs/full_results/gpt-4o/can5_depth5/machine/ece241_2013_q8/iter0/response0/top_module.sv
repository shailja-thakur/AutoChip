module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            S:    next_state = (x) ? S1 : S;
            S1:   next_state = (x) ? S1 : S10;
            S10:  next_state = (x) ? S1 : S;
            default: next_state = S;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S:    z = 1'b0;
            S1:   z = 1'b0;
            S10:  z = x;
            default: z = 1'b0;
        endcase
    end
    
endmodule
