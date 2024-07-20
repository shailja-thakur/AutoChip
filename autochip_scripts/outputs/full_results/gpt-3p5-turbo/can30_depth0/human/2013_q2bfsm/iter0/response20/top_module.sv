module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg f_reg;
reg g_reg;
reg [1:0] state_reg;
reg [2:0] x_reg;
reg [1:0] y_reg;

always @(posedge clk) begin
    if (~resetn) begin
        f_reg <= 0;
        g_reg <= 0;
        state_reg <= 2'b00;
        x_reg <= 3'b000;
        y_reg <= 2'b00;
    end else begin
        case (state_reg)
            2'b00:
                f_reg <= 1; // Set f to 1 for one clock cycle
            2'b01:
                f_reg <= 0; // Reset f to 0 after one clock cycle
            2'b10:
                f_reg <= 0; // Reset f to 0 after one clock cycle
        endcase
        
        case (state_reg)
            2'b00:
                if (x_reg == 3'b101)
                    state_reg <= 2'b01; // Transition to state B if x is 101
            2'b01:
                if (y_reg == 2'b01)
                    state_reg <= 2'b10; // Transition to state C if y is 1
                else
                    state_reg <= 2'b00; // Transition back to state A if y is not 1 within two clock cycles
            2'b10:
                state_reg <= 2'b10; // Stay in state C
        endcase
        
        // Shift the values of x and y registers
        x_reg <= {x_reg[1:0], x};
        y_reg <= {y_reg[0], y};
    
        // Update g based on the current state
        case (state_reg)
            2'b00:
                g_reg <= 0; // Set g to 0 in state A
            2'b01:
                g_reg <= 0; // Set g to 0 in state B
            2'b10:
                g_reg <= 1; // Set g to 1 in state C
        endcase
    end
end

assign f = f_reg;
assign g = g_reg;

endmodule
