module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initial state is A
    end else begin
        case (state)
            3'b000: begin // State A
                if (w) begin
                    state <= 3'b001; // Transition to state B
                end else begin
                    state <= 3'b000; // Stay in state A
                end
            end
            
            3'b001: begin // State B
                if (w) begin
                    state <= 3'b010; // Transition to state C
                end else begin
                    state <= 3'b100; // Transition to state D
                end
            end
            
            3'b010: begin // State C
                if (w) begin
                    state <= 3'b110; // Transition to state E
                end else begin
                    state <= 3'b100; // Transition to state D
                end
            end
            
            3'b100: begin // State D
                if (w) begin
                    state <= 3'b011; // Transition to state F
                end else begin
                    state <= 3'b000; // Transition to state A
                end
            end
            
            3'b110: begin // State E
                if (w) begin
                    state <= 3'b110; // Stay in state E
                end else begin
                    state <= 3'b100; // Transition to state D
                end
            end
            
            3'b011: begin // State F
                if (w) begin
                    state <= 3'b010; // Transition to state C
                end else begin
                    state <= 3'b100; // Transition to state D
                end
            end
        endcase
    end
end

assign z = (state == 3'b110) || (state == 3'b011);

endmodule
