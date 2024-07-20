module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State encoding using one-hot method
    typedef enum logics [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;
    
    state_t state, next_state;

    // Output logic
    assign z = (state == A) ? x : ~x;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State update logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
endmodule
