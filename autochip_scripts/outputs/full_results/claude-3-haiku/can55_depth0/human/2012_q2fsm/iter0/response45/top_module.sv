module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encoding
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// State register
reg [2:0] state, next_state;

// State table
always @(*) begin
    case (state)
        A: begin
            if (w)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if (w)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        default:
            next_state = A;
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
