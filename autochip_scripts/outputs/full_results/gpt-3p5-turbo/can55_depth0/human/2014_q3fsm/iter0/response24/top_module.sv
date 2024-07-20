module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin // State A
                if (s == 1) begin
                    state <= 2'b01; // Transition to state B
                end else begin
                    state <= 2'b00;
                end
            end
            2'b01: begin // State B
                if (w == 1) begin
                    state <= 2'b10; // Transition to state C
                end else begin
                    state <= 2'b01;
                end
            end
            2'b10: begin // State C
                if (w == 1) begin
                    state <= 2'b11; // Transition to state D
                end else begin
                    state <= 2'b01; // Transition back to state B
                end
            end
            2'b11: begin // State D
                if (w == 1) begin
                    z <= 1; // Set output z to 1
                end else begin
                    z <= 0; // Set output z to 0
                end
                
                state <= 2'b00; // Transition back to state A
            end
        endcase
    end
end

endmodule
