module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoding for the states
reg [1:0] state, next_state;
localparam A = 2'b01, B = 2'b10;

// Combinational logic for next state
always @(*) begin
    case (state)
        A: next_state = (x) ? B : A;
        B: next_state = (x) ? B : B;
        default: next_state = A;
    endcase
end

// Combinational logic for output
assign z = (state == B) ? ~x : x;

// Sequential logic for state register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
