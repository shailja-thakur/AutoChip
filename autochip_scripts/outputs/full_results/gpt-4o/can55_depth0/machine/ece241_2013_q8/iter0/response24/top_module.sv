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
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S: next_state = (x == 1'b0) ? S : S1;
            S1: next_state = (x == 1'b0) ? S10 : S1;
            S10: next_state = (x == 1'b0) ? S : S1;
            default: next_state = S;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S: z = 1'b0;
            S1: z = 1'b0;
            S10: z = x;
            default: z = 1'b0;
        endcase
    end
endmodule
