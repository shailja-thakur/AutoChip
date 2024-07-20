module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initialize to state A
    end
    else begin
        case (state)
            3'b000: // State A
                if (x) begin
                    state <= 3'b001; // Go to state B
                end
                else begin
                    state <= 3'b000; // Stay in state A
                end
            3'b001: // State B
                if (x) begin
                    state <= 3'b101; // Go to state E
                end
                else begin
                    state <= 3'b001; // Stay in state B
                end
            3'b010: // State C
                if (x) begin
                    state <= 3'b001; // Go to state B
                end
                else begin
                    state <= 3'b010; // Stay in state C
                end
            3'b011: // State D
                if (x) begin
                    state <= 3'b010; // Go to state C
                end
                else begin
                    state <= 3'b001; // Go to state B
                end
            3'b101: // State E
                if (x) begin
                    state <= 3'b101; // Stay in state E
                end
                else begin
                    state <= 3'b011; // Go to state D
                end
            default:
                state <= 3'b000; // Go to state A
        endcase
    end
end

always @(*) begin
    case (state)
        3'b011, 3'b101: // State D or E
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
