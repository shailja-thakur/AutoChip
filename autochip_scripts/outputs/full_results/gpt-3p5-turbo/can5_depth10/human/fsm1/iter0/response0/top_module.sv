module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // Reset to state B
        end else begin
            case (state)
                2'b00: begin // State A
                    if (in) begin
                        state <= 2'b01; // Transition to state A
                    end else begin
                        state <= 2'b10; // Transition to state B
                    end
                end
                2'b01: begin // State B
                    if (in) begin
                        state <= 2'b01; // Transition to state B
                    end else begin
                        state <= 2'b00; // Transition to state A
                    end
                end
                default: state <= 2'b10; // Default to state B
            endcase
        end
    end
    
    assign out = (state == 2'b00) ? 1 : 0;
    
endmodule
