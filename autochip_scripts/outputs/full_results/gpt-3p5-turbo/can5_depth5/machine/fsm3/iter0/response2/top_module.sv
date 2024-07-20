module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to state A
            out <= 0; // Reset output to 0
        end else begin
            case (state)
                2'b00: begin // State A
                    if (in) begin
                        state <= 2'b01; // Next state B
                    end else begin
                        state <= 2'b00; // Next state A
                    end
                end
                2'b01: begin // State B
                    if (in) begin
                        state <= 2'b01; // Next state B
                    end else begin
                        state <= 2'b10; // Next state C
                    end
                end
                2'b10: begin // State C
                    if (in) begin
                        state <= 2'b11; // Next state D
                    end else begin
                        state <= 2'b00; // Next state A
                    end
                end
                2'b11: begin // State D
                    if (in) begin
                        state <= 2'b01; // Next state B
                    end else begin
                        state <= 2'b10; // Next state C
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b11); // Set output to 1 when in state D
    
endmodule
