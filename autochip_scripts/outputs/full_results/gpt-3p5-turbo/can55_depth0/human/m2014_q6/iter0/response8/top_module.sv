module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (w)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (w)
                next_state = D;
            else
                next_state = C;
        end
        C: begin
            if (w)
                next_state = D;
            else
                next_state = E;
        end
        D: begin
            if (w)
                next_state = A;
            else
                next_state = F;
        end
        E: begin
            if (w)
                next_state = D;
            else
                next_state = E;
        end
        F: begin
            if (w)
                next_state = D;
            else
                next_state = C;
        end
    endcase
end

always @* begin
    case (state)
        A: z = 0;
		D: z = 0;
        E: z = 1;
        default: z = 1;
    endcase
end

endmodule
