module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset state A
        z <= 0;
    end else begin
        case (state)
            3'b000: begin // State A
                if (s) begin
                    state <= 3'b001; // Move to state B
                end
            end
            3'b001: begin // State B
                state <= 3'b010; // Move to state C
            end
            3'b010: begin // State C
                if (w) begin
                    state <= 3'b011; // Move to state D
                end else begin
                    state <= 3'b100; // Move to state E
                end
            end
            3'b011: begin // State D
                if (w) begin
                    state <= 3'b111; // Move to state F
                    z <= 1; // Set output z to 1
                end else begin
                    state <= 3'b100; // Move to state E
                end
            end
            3'b100: begin // State E
                if (w) begin
                    state <= 3'b010; // Move to state C
                end
            end
            3'b111: begin // State F
                state <= 3'b110; // Move to state G
                z <= 0; // Set output z to 0
            end
            3'b110: begin // State G
                state <= 3'b100; // Move to state E
            end
        endcase
    end
end

endmodule
