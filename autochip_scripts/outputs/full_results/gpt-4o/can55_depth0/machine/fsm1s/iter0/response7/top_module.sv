module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definition
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic block to update state on rising clk edge
    always @(posedge clk or posedge reset) begin
        if (reset) state <= B;
        else state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1 : 0;
    end
endmodule
