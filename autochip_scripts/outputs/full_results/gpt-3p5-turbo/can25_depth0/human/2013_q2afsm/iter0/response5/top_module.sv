module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state or r) begin
    case (state)
        A: begin
            if (r[0] & ~r[1] & ~r[2])
                next_state = A;
            else if (r[0] & ~r[1])
                next_state = B;
            else if (r[0] & ~r[2])
                next_state = C;
            else if (r[0])
                next_state = D;
            else
                next_state = A;
        end
        B: begin
            if (r[0])
                next_state = B;
            else
                next_state = A;
        end
        C: begin
            if (r[1])
                next_state = C;
            else
                next_state = A;
        end
    endcase
end

// Output assignments
assign g[0] = (state == B);
assign g[1] = (state == C);
assign g[2] = (state == D);
endmodule
