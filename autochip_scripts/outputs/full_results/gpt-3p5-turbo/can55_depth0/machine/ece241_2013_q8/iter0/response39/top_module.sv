module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

reg state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case ({x, state})
        2'b0S: next_state = S;
        2'b1S: next_state = S1;
        2'b0S1: next_state = S10;
        2'b1S1: next_state = S1;
        2'b0S10: next_state = S;
        2'b1S10: next_state = S1;
    endcase
end

always @* begin
    case (state)
        S, S1: z = 1'b0;
        S10: z = x;
    endcase
end

endmodule
