module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // default state
        endcase
    end
    
    // State update and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
