module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    // State encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // default/reset case
        endcase
    end

    // State register (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
