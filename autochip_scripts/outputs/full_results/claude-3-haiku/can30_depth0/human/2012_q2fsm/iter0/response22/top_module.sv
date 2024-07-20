module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Assign state codes
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3, E = 2'd4, F = 2'd5;

// State registers
reg [1:0] state, next_state;

// State table
always @(*) begin
    case (state)
        A: begin
            if (w) next_state = B;
            else next_state = A;
        end
        B: begin
            if (w) next_state = C;
            else next_state = D;
        end
        C: begin
            if (w) next_state = E;
            else next_state = D;
        end
        D: begin
            if (w) next_state = F;
            else next_state = A;
        end
        E: begin
            if (w) next_state = E;
            else next_state = D;
        end
        F: begin
            if (w) next_state = C;
            else next_state = D;
        end
        default: next_state = A;
    endcase
end

// State flip-flops
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
assign z = (state == E) || (state == F);

endmodule
