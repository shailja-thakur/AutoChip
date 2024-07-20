module top_module (
    input clk,
    input areset,
    input x,
    output reg z // Added reg keyword for output z
);

parameter A = 1'b0; // Initialized parameter values for states A and B
parameter B = 1'b1;

reg state; // Added register for storing state

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
            end
            B: begin
                state <= B;
            end
        endcase
    end
end

assign z = (state == A && x) || (state == B && !x); // Modified the condition for setting output z

endmodule
