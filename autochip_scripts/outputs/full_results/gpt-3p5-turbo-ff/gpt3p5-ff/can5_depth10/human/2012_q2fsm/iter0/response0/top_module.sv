module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State codes
parameter A = 3'd0;
parameter B = 3'd1;
parameter C = 3'd2;
parameter D = 3'd3;
parameter E = 3'd4;
parameter F = 3'd5;

reg [2:0] state, next_state;

// Combinational logic
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
            if (z)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (z)
                next_state = C;
            else
                next_state = D;
        end
        default: next_state = A;
    endcase
end

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output assignment
always @(state) begin
    case (state)
        E: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
