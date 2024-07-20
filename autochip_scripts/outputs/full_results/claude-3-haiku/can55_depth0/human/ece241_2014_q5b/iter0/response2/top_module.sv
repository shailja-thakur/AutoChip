module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoded state machine
reg [1:0] state, next_state;
parameter A = 2'b01, B = 2'b10;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (x == 0) next_state = A;
            else next_state = B;
        end
        B: begin
            if (x == 0) next_state = B;
            else next_state = B;
        end
        default: next_state = A;
    endcase
end

// Output logic
assign z = (state == B && x == 0) ? 1 : 0;

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
