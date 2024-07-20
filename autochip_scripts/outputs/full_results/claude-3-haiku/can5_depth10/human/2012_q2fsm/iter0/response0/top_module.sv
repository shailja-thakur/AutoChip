module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the state codes
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 3'b100, F = 3'b101;

// Register to hold the current state
reg [2:0] current_state, next_state;

// State table logic
always @(*) begin
    case (current_state)
        A: begin
            if (w) next_state = B;
            else next_state = A;
        end
        B: begin
            if (w) next_state = C;
            else next_state = D;
        end
        C: begin
            if (w) next_state = E;
            else next_state = D;
        end
        D: begin
            if (w) next_state = F;
            else next_state = A;
        end
        E: begin
            if (w) next_state = E;
            else next_state = D;
        end
        F: begin
            if (w) next_state = C;
            else next_state = D;
        end
        default: next_state = A;
    endcase
end

// State flip-flop logic
always @(posedge clk) begin
    if (reset) current_state <= A;
    else current_state <= next_state;
end

// Output logic
assign z = (current_state == E) | (current_state == F);

endmodule
