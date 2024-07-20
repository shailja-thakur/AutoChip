module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Declare the states using one-hot encoding
parameter A = 3'b001, B = 3'b010, INVALID = 3'b100;

// Declare the state register
reg [2:0] state, next_state;

// Combinational logic for next state
always @(*) begin
    case (state)
        A: begin
            if (x == 0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 0)
                next_state = B;
            else
                next_state = B;
        end
        default:
            next_state = INVALID;
    endcase
end

// Combinational logic for output
assign z = (state == B && x == 0) || (state == A && x == 1);

// Sequential logic for state register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
