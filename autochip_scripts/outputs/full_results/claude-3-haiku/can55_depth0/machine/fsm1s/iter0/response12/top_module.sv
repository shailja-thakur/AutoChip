module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B; // Reset state to initial state B
    end
    else begin
        case (state)
            A: begin
                state <= (in) ? A : B;
            end
            B: begin
                state <= (in) ? B : A;
            end
        endcase
    end
end

always @(*) begin
    out = (state == B) ? 1'b1 : 1'b0; // Assign output based on current state
end

endmodule
