module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        S_A = 2'b00,
        S_B = 2'b01
    } state_t;

    // State register
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_A: begin
                if (in)
                    next_state = S_A;
                else
                    next_state = S_B;
            end

            S_B: begin
                if (in)
                    next_state = S_B;
                else
                    next_state = S_A;
            end

            default: next_state = S_B;
        endcase
    end

    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S_A: out = 0;
            S_B: out = 1;
            default: out = 1;
        endcase
    end
endmodule
