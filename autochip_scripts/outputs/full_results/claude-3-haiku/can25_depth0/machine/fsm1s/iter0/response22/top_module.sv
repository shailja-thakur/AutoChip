module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset)
        state <= B; // Reset to initial state
    else begin
        case (state)
            A: state <= (in) ? A : B; // Transition from A to A or B based on in
            B: state <= (in) ? B : A; // Transition from B to B or A based on in
        endcase
    end
end

always @(*) begin
    out = (state == B); // Output is high when in state B
end

endmodule
