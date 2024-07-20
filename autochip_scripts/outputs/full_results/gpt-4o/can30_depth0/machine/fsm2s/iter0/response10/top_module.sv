module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            out <= 1'b0;  // Output is low when in state A
        end else begin
            state <= next_state;
            out <= (next_state == B) ? 1'b1 : 1'b0;  // Output is high when in state B
        end
    end
endmodule
