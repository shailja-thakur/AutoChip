module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state; // 3-bit register to represent the states

// Define the different states using parameters
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Assign the initial state of the state machine to state A
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Combinational logic to determine the next state
always @(state, w) begin
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

// Output set to 1 when current state is E or F
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
