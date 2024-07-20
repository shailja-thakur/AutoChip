module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state encoding
    parameter A = 1'b0,
              B = 1'b1;
    
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
