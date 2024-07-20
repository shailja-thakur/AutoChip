module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    parameter A = 1'b0, B = 1'b1;
    reg state;

    always @(posedge clk) begin
        if (reset)
            state <= B; // Reset state to initial state B
        else
            case (state)
                A: state <= (in) ? A : B; // Transition to A if in is high, else B
                B: state <= (in) ? B : A; // Transition to B if in is high, else A
            endcase
    end

    assign out = (state == B) ? 1'b1 : 1'b0; // Set output high if state is B, else low

endmodule
