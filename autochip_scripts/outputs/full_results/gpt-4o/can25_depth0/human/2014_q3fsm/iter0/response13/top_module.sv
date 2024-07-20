module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state parameters
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    state_t state, next_state;

    reg [1:0] count_w1; // Counter to keep track of number of w=1

    // Synchronous state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = state;
        z = 1'b0;

        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                count_w1 = 0;
                next_state = C;
            end

            C: begin
                count_w1 = count_w1 + w;
                next_state = D;
            end

            D: begin
                count_w1 = count_w1 + w;
                if (count_w1 == 2)
                    z = 1'b1;
                next_state = B;
            end

            default: next_state = A;
        endcase
    end

endmodule
