module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    assign z = (state == A) ? x : ~x;

    // State flip-flop with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
