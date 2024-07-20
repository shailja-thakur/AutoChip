module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// State variables
reg [1:0] state, next_state;

// Define the two states
localparam A = 2'd0;
localparam B = 2'd1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: begin
            if (j)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (k)
                next_state = A;
            else
                next_state = B;
        end
        default: next_state = A; // Reset to state A
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Assign the output based on the current state
always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0; // Reset to 0
    endcase
end

endmodule
