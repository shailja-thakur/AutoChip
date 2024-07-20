module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state; // Internal state representation

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b001; // Reset state A
    else begin
        case (state)
            3'b001:
                if (x)
                    state <= 3'b010; // State A, x high -> B
                // else state remains A
            3'b010:
                if (x)
                    state <= 3'b100; // State B, x high -> E
                // else state remains B
            3'b011:
                if (x)
                    state <= 3'b010; // State C, x high -> B
                // else state remains C
            3'b100:
                if (x)
                    state <= 3'b011; // State D, x high -> C
                // else state remains D
            3'b101:
                if (x)
                    state <= 3'b100; // State E, x high -> E
                // else state remains E
            default:
                state <= 3'b001;
        endcase
    end
end

always @(state) begin
    z = (state == 3'b100 || state == 3'b101); // Output is high when state is D or E
end

endmodule
