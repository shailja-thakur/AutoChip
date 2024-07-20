module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset to state A
    end else begin
        case (state)
            3'b000: begin // State A
                if (w) begin
                    state <= 3'b000; // Transition from state A to state A when w is high
                end else begin
                    state <= 3'b001; // Transition from state A to state B when w is low
                end
            end
            3'b001: begin // State B
                if (w) begin
                    state <= 3'b011; // Transition from state B to state D when w is high
                end else begin
                    state <= 3'b010; // Transition from state B to state C when w is low
                end
            end
            3'b010: begin // State C
                if (w) begin
                    state <= 3'b011; // Transition from state C to state D when w is high
                end else begin
                    state <= 3'b100; // Transition from state C to state E when w is low
                end
            end
            3'b011: begin // State D
                if (w) begin
                    state <= 3'b000; // Transition from state D to state A when w is high
                end else begin
                    state <= 3'b101; // Transition from state D to state F when w is low
                end
            end
            3'b100: begin // State E
                if (w) begin
                    state <= 3'b011; // Transition from state E to state D when w is high
                end else begin
                    state <= 3'b100; // Transition from state E to state E when w is low
                end
            end
            3'b101: begin // State F
                if (w) begin
                    state <= 3'b011; // Transition from state F to state D when w is high
                end else begin
                    state <= 3'b010; // Transition from state F to state C when w is low
                end
            end
        endcase
    end
end

assign z = (state == 3'b100) || (state == 3'b101); // Output z is high when the state machine is in state E or F, and low otherwise

endmodule
