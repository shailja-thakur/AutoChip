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
                    state <= 3'b000; // Next state is A
                end
            3'b001: // State B
                if (x) begin
                    state <= 3'b101; // Next state is E
                end
                else begin
                    state <= 3'b001; // Next state is B
                end
            3'b010: // State C
                if (x) begin
                    state <= 3'b001; // Next state is B
                end
                else begin
                    state <= 3'b010; // Next state is C
                end
            3'b011: // State D
                if (x) begin
                    state <= 3'b010; // Next state is C
                end
                else begin
                    state <= 3'b001; // Next state is B
                end
            3'b101: // State E
                if (x) begin
                    state <= 3'b101; // Next state is E
                end
                else begin
                    state <= 3'b011; // Next state is D
                end
            default:
                state <= 3'b000; // Reset to state A
        endcase
    end
end

always @* begin
    case (state)
        3'b011, 3'b101: // State D or E
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
