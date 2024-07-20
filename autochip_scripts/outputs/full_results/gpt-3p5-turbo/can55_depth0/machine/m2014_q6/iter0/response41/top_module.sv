module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State definitions
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Registers
reg [2:0] current_state;
reg [2:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= A; // Reset to state A
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// State transition logic
always @(current_state, w) begin
    case (current_state)
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

// Output logic
always @(current_state) begin
    case (current_state)
        E, F: z = 1'b1; // Output is high when in state E or F
        default: z = 1'b0; // Output is low otherwise
    endcase
end

endmodule
