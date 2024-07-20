module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;

// Define the states
parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;     // Reset to state B
        out <= 1'b1;    // Set initial value of output to 1
    end else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B; // Stay in state B
                end else begin
                    state <= A; // Transition to state A
                end
            end
            A: begin
                if (in) begin
                    state <= A; // Stay in state A
                end else begin
                    state <= B; // Transition to state B
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        B: out = 1'b1; // Output is 1 in state B
        A: out = 1'b0; // Output is 0 in state A
    endcase
end

endmodule
