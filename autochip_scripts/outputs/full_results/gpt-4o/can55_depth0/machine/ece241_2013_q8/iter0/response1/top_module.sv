module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            S: begin
                next_state = x ? S1 : S;
                z = 0;
            end
            S1: begin
                next_state = x ? S1 : S10;
                z = 0;
            end
            S10: begin
                next_state = x ? S1 : S;
                z = x;
            end
            default: begin
                next_state = S;  // Default to a known state
                z = 0;
            end
        endcase
    end

endmodule
