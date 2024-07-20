module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State codes
localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// State flip-flops
reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// State table
always @(*) begin
    case (state)
        A: next_state = (w) ? B : A;
        B: next_state = (w) ? C : D;
        C: next_state = (w) ? E : D;
        D: next_state = (w) ? F : A;
        E: next_state = (w) ? E : D;
        F: next_state = (w) ? C : D;
    endcase
end

// Output logic
assign z = (state == E) || (state == F);

endmodule
