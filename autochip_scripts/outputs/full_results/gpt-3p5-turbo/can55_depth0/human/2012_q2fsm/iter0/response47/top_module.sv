module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

// Declare state register
reg [2:0] state_reg;
reg [2:0] next_state;

// Output assignment
assign z = (state_reg == E || state_reg == F) ? 1'b1 : 1'b0;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) // Reset state
        state_reg <= A;
    else
        state_reg <= next_state;
end

// State transition logic
always @(state_reg or w) begin
    case (state_reg)
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
