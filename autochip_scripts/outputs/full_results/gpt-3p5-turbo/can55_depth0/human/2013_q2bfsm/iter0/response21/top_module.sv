module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

// Define the states
typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_type;

// Define the state and next_state variables
state_type state, next_state;

// Define internal variables
logic f_reg, g_reg;
logic x_reg[2:0];
logic y_reg[1:0];

always_ff @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        // Reset state and registers
        state <= STATE_A;
        f_reg <= 0;
        g_reg <= 0;
        x_reg <= 3'b0;
        y_reg <= 2'b0;
    end else begin
        // Determine the next state based on the current state and inputs
        case (state)
            STATE_A: begin
                if (resetn) begin
                    f_reg <= 1;
                    next_state <= STATE_B;
                end else begin
                    f_reg <= 0;
                    next_state <= STATE_A;
                end
            end
            
            STATE_B: begin
                if (x_reg == 3'b101) begin
                    g_reg <= 1;
                    next_state <= STATE_C;
                end else begin
                    g_reg <= 0;
                    next_state <= STATE_B;
                end
            end
            
            STATE_C: begin
                if (y_reg == 2'b01) begin
                    g_reg <= 1;
                    next_state <= STATE_D;
                end else if (y_reg != 2'b00) begin
                    g_reg <= 0;
                    next_state <= STATE_C;
                end
            end
            
            STATE_D: begin
                g_reg <= 1;
                next_state <= STATE_D;
            end
        endcase
        
        // Update the state and registers
        state <= next_state;
        x_reg <= {x_reg[1:0], x};
        y_reg <= {y_reg[0], y};
    end
end

assign f = f_reg;
assign g = g_reg;

endmodule
