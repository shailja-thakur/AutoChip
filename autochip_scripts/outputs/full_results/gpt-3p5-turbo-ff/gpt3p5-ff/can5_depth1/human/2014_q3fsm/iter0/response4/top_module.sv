module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Reset state A
            z <= 0;
        end else begin
            state <= next_state;
            case (state)
                2'b00: begin // State A
                    if (s) begin
                        next_state <= 2'b01; // Move to state B
                    end else begin
                        next_state <= 2'b00; // Stay in state A
                    end
                end
                2'b01: begin // State B
                    if (w) begin
                        next_state <= 2'b10; // Move to state C
                    end else begin
                        next_state <= 2'b01; // Stay in state B
                    end
                end
                2'b10: begin // State C
                    if (w) begin
                        next_state <= 2'b11; // Move to state D
                    end else begin
                        next_state <= 2'b10; // Stay in state C
                    end
                end
                2'b11: begin // State D
                    if (w) begin
                        z <= 1; // Set output z to 1
                        next_state <= 2'b00; // Move back to state A
                    end else begin
                        z <= 0; // Set output z to 0
                        next_state <= 2'b10; // Stay in state D
                    end
                end
                default: next_state <= 2'b00; // Default state: A
            endcase
        end
    end
    
endmodule
