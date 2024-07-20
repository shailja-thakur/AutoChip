module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state_reg, next_state_reg;

// Define the states
parameter B = 2'b00;
parameter A = 2'b01;

// Define the state transitions based on input
always @(posedge clk or posedge areset) begin
    if (areset)
        state_reg <= B;
    else
        state_reg <= next_state_reg;
end

// Define the next states based on the current state and input
always @* begin
    case (state_reg)
        B: begin
            if (in)
                next_state_reg = B;
            else
                next_state_reg = A;
        end
        A: begin
            if (in)
                next_state_reg = A;
            else
                next_state_reg = B;
        end
        default: next_state_reg = B;
    endcase
end

// Define the outputs based on the current state
always @* begin
    case (state_reg)
        B: out = 1'b1;
        A: out = 1'b0;
        default: out = 1'b1;
    endcase
end

endmodule
