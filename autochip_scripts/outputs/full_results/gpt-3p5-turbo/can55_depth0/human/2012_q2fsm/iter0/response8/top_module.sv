module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    case(state)
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
        default: next_state = A;
    endcase
end

always @(state) begin
    case(state)
        A: z = 0;
        E: z = 1;
        default: z = 0;
    endcase
end

endmodule
