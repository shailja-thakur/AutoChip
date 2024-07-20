module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        B = 2'b00,
        A = 2'b01
    } state_t;

    // State registers
    reg state, next_state;

    // Output logic based on state
    always @(state) begin
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Synchronous reset
        end else begin
            state <= next_state;
        end
    end

    // Next state generation
    always @(state or in) begin
        case(state)
            B: if (in) next_state = B; else next_state = A;
            A: if (in) next_state = A; else next_state = B;
            default: next_state = B;
        endcase
    end

endmodule
