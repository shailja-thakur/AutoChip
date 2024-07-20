module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the state codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(state or w) begin
    case (state)
        A: 
            if (w)
                next_state = B;
            else
                next_state = A;
        B:
            if (w)
                next_state = C;
            else
                next_state = D;
        C:
            if (w)
                next_state = E;
            else
                next_state = D;
        D:
            if (w)
                next_state = F;
            else
                next_state = A;
        E:
            if (w)
                next_state = E;
            else
                next_state = D;
        F:
            if (w)
                next_state = C;
            else
                next_state = D;
    endcase
end

// Output assignment
assign z = (state == E || state == F);

endmodule
