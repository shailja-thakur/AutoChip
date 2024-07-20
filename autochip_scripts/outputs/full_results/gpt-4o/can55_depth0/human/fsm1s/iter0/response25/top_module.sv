module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] { B=2'b00, A=2'b01 } state_t;
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        case (state)
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 1;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
                out = 0;
            end
            default: begin
                next_state = B;
                out = 1;
            end
        endcase
    end

endmodule
