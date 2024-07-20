module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case(state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end
    
endmodule
