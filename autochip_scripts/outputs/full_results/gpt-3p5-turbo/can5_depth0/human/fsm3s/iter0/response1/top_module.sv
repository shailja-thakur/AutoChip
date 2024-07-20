module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    reg [1:0] state;
    reg [1:0] next_state;
    reg out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'h0; // Reset to state A
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            2'h0: begin // State A
                if (in) begin
                    next_state = 2'h1; // Next state if input is 1
                end else begin
                    next_state = 2'h0; // Next state if input is 0
                end
                out_reg = 1'b0; // Output in state A is 0
            end
            2'h1: begin // State B
                if (in) begin
                    next_state = 2'h1; // Next state if input is 1
                end else begin
                    next_state = 2'h2; // Next state if input is 0
                end
                out_reg = 1'b0; // Output in state B is 0
            end
            2'h2: begin // State C
                if (in) begin
                    next_state = 2'h3; // Next state if input is 1
                end else begin
                    next_state = 2'h0; // Next state if input is 0
                end
                out_reg = 1'b0; // Output in state C is 0
            end
            2'h3: begin // State D
                if (in) begin
                    next_state = 2'h1; // Next state if input is 1
                end else begin
                    next_state = 2'h2; // Next state if input is 0
                end
                out_reg = 1'b1; // Output in state D is 1
            end
        endcase
    end
    
    always @(posedge clk) begin
        out <= out_reg; // Assign output
    end
    
endmodule
