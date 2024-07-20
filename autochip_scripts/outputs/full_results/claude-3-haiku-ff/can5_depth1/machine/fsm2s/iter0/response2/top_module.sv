module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// State variable
reg state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset state to A
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (j) begin
                    // Transition to state B
                    state <= B;
                end
                else begin
                    // Remain in state A
                    state <= A;
                end
            end
            B: begin
                if (k) begin
                    // Transition to state A
                    state <= A;
                end
                else begin
                    // Remain in state B
                    state <= B;
                end
            end
            default: begin
                // Invalid state, go to state A
                state <= A;
            end
        endcase
    end
end

// Output logic
always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
