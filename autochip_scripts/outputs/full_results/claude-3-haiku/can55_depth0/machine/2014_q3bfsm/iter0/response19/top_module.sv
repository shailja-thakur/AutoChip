module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b000; // State A
    end
    else begin
        case (state)
            3'b000: // State A
                if (x) begin
                    state <= 3'b001; // Next state is B
                end
                else begin
                    state <= 3'b000; // Remain in state A
                end
            3'b001: // State B
                if (x) begin
                    state <= 3'b100; // Next state is E
                end
                else begin
                    state <= 3'b001; // Remain in state B
                end
            3'b010: // State C
                if (x) begin
                    state <= 3'b001; // Next state is B
                end
                else begin
                    state <= 3'b010; // Remain in state C
                end
            3'b011: // State D
                if (x) begin
                    state <= 3'b010; // Next state is C
                end
                else begin
                    state <= 3'b001; // Next state is B
                end
            3'b100: // State E
                if (x) begin
                    state <= 3'b100; // Remain in state E
                end
                else begin
                    state <= 3'b011; // Next state is D
                end
            default:
                state <= 3'b000; // Reset to state A
        endcase
    end
end

always @(*) begin
    case (state)
        3'b011, 3'b100: // States D and E
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
