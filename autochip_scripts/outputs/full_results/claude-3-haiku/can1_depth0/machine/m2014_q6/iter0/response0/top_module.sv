module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// Declare the current and next state registers
reg [2:0] current_state, next_state;

// Next state logic
always @(*) begin
    case (current_state)
        A: begin
            if (w) next_state = A;
            else next_state = B;
        end
        B: begin
            if (w) next_state = D;
            else next_state = C;
        end
        C: begin
            if (w) next_state = D;
            else next_state = E;
        end
        D: begin
            if (w) next_state = A;
            else next_state = F;
        end
        E: begin
            if (w) next_state = D;
            else next_state = E;
        end
        F: begin
            if (w) next_state = D;
            else next_state = C;
        end
        default: next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State register update
always @(posedge clk) begin
    if (reset) current_state <= A;
    else current_state <= next_state;
end

endmodule
