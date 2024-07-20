module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define states
parameter S_B = 1'b0;
parameter S_A = 1'b1;

// Define the state register and next state register
reg state_reg, next_state_reg;
// Define output register
reg out_reg;

// Synchronous reset
always @(posedge clk or posedge areset) begin
    if (areset)
        state_reg <= S_B;
    else
        state_reg <= next_state_reg;
end

// Combinational logic to determine next state and output
always @* begin
    case (state_reg)
        S_B: begin
            if (in)
                next_state_reg = S_B;
            else
                next_state_reg = S_A;
            out_reg = 1'b0;
        end
        S_A: begin
            if (in)
                next_state_reg = S_A;
            else
                next_state_reg = S_B;
            out_reg = 1'b1;
        end
    endcase
end

// Assign output signal
assign out = out_reg;

endmodule
