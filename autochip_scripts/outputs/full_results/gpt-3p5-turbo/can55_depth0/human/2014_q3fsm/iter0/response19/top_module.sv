module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;  // reset state A
    end else begin
        case(state)
            2'b00: begin  // State A
                if (s) begin
                    state <= 2'b01;  // Transition to state B
                end
            end
            2'b01: begin  // State B
                state <= 2'b10;  // Transition to state C
            end
            2'b10: begin  // State C
                state <= 2'b00;  // Transition to state A
                if (w && $countones(w) == 2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
            end
        endcase
    end
end

endmodule
