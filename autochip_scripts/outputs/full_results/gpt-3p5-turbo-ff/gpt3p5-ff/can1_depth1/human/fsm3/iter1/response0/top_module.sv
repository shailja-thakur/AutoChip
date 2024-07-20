module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    reg [1:0] state;
    reg [1:0] next_state;
    reg      out_reg;
    
    // Positive edge triggered asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to state A
        end else begin
            state <= next_state;
            out <= out_reg;
        end
    end
    
    // State transition logic
    always @(state or in) begin
        case (state)
            2'b00: begin    // State A
                if (in) begin
                    next_state = 2'b01;  // Next state B
                    out_reg = 1'b0;
                end else begin
                    next_state = 2'b00;  // Next state A
                    out_reg = 1'b0;
                end
            end
            2'b01: begin    // State B
                if (in) begin
                    next_state = 2'b01;  // Next state B
                    out_reg = 1'b0;
                end else begin
                    next_state = 2'b10;  // Next state C
                    out_reg = 1'b0;
                end
            end
            2'b10: begin    // State C
                if (in) begin
                    next_state = 2'b11;  // Next state D
                    out_reg = 1'b0;
                end else begin
                    next_state = 2'b00;  // Next state A
                    out_reg = 1'b0;
                end
            end
            2'b11: begin    // State D
                if (in) begin
                    next_state = 2'b01;  // Next state B
                    out_reg = 1'b1;
                end else begin
                    next_state = 2'b10;  // Next state C
                    out_reg = 1'b0;
                end
            end
            default: begin    // Default case
                next_state = 2'b00;  // Next state A
                out_reg = 1'b0;
            end
        endcase
    end
    
endmodule
