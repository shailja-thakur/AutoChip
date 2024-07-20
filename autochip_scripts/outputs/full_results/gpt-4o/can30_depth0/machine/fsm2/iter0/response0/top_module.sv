module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define states
    typedef enum reg [1:0] {A=2'b00, B=2'b01} state_t;
    state_t state, next_state;

    // Combinational block to determine next state
    always @(*) begin
        case(state)
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
            default: next_state = A;
        endcase
    end

    // Clocked block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
