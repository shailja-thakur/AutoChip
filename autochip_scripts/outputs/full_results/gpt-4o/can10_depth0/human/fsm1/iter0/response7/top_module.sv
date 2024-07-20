module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic (Moore machine)
    always @(*) begin
        case(state)
            B: begin
                out = 1;
                if (in) next_state = B;
                else next_state = A;
            end
            A: begin
                out = 0;
                if (in) next_state = A;
                else next_state = B;
            end
            default: begin
                out = 1;
                next_state = B; // default to state B to handle any unforeseen states
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

endmodule
