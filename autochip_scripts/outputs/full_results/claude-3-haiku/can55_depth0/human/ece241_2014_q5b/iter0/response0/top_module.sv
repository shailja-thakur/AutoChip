module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam A = 2'b01, B = 2'b10;
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: next_state = (x) ? B : A;
        B: next_state = (x) ? B : B;
        default: next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        A: z = (x) ? 1 : 0;
        B: z = (x) ? 0 : 1;
        default: z = 0;
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
