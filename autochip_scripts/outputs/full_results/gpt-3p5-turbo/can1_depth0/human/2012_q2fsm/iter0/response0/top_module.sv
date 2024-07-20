module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

assign z = (state == E || state == F);

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
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
    endcase
end

endmodule
