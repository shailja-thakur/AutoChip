module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// State variables
reg state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A; // Reset to state A
    end
    else begin
        case (state)
            A: begin
                if (j) begin
                    state <= B; // Transition to state B
                end
                else begin
                    state <= A; // Remain in state A
                end
            end
            B: begin
                if (k) begin
                    state <= A; // Transition to state A
                end
                else begin
                    state <= B; // Remain in state B
                end
            end
            default: state <= A; // Default to state A
        endcase
    end
end

// Output logic
always @(*) begin
    case (state)
        A: out = 1'b0; // Output low when in state A
        B: out = 1'b1; // Output high when in state B
        default: out = 1'b0; // Default to low output
    endcase
end

endmodule
