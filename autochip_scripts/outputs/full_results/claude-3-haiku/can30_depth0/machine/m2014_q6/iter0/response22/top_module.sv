module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] current_state, next_state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// State transition logic
always @(*)
begin
    case (current_state)
        A:
            if (w) next_state = A;
            else next_state = B;
        B:
            if (w) next_state = D;
            else next_state = C;
        C:
            if (w) next_state = D;
            else next_state = E;
        D:
            if (w) next_state = A;
            else next_state = F;
        E:
            if (w) next_state = D;
            else next_state = E;
        F:
            if (w) next_state = D;
            else next_state = C;
        default:
            next_state = A;
    endcase
end

// State register
always @(posedge clk)
begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

// Output logic
always @(*)
begin
    case (current_state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
