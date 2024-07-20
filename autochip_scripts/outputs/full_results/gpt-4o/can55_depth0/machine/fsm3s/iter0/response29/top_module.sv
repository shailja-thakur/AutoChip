module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State enumerations
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: if (in)
                   next_state = B;
               else
                   next_state = A;
            B: if (in)
                   next_state = B;
               else
                   next_state = C;
            C: if (in)
                   next_state = D;
               else
                   next_state = A;
            D: if (in)
                   next_state = B;
               else
                   next_state = C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(current_state) begin
        case (current_state)
            D: out = 1;
            default: out = 0;
        endcase
    end

endmodule
