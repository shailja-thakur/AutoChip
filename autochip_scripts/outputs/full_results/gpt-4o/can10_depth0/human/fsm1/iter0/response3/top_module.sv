module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        B = 2'b00,
        A = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
