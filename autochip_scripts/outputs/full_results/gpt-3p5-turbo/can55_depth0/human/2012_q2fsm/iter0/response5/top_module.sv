module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State variables
reg [2:0] current_state, next_state;

// State codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State flip-flops
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

// State transition logic
always @* begin
    case (current_state)
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

// Output logic
always @* begin
    case (current_state)
        A, B, C, D: z = 0;
        E, F: z = 1;
    endcase
end

endmodule
