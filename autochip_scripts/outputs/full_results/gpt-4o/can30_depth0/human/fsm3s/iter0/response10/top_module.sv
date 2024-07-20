module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in == 1'b0) next_state = A; else next_state = B;
            B: if (in == 1'b0) next_state = C; else next_state = B;
            C: if (in == 1'b0) next_state = A; else next_state = D;
            D: if (in == 1'b0) next_state = C; else next_state = B;
            default: next_state = A; // Default state
        endcase
    end

    // State register and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
