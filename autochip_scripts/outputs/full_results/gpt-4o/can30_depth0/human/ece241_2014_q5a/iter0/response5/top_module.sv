module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {S0, S1} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(state or x) begin
        case (state)
            S0: begin
                z = x;  // Following 2's complement will start with the first 1 found
                if (x == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                z = ~x;  // From first 1 onwards, invert the bits
                next_state = S1;
            end
            default: begin
                next_state = S0;
                z = x;
            end
        endcase
    end
endmodule
