module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State enum
typedef enum logic [2:0] {
    A, B, C, D, E, F
} state_type;

// Variables
reg [2:0] current_state;
reg [2:0] next_state;

// State machine logic
always_ff @(posedge clk) begin
    // Reset state
    if (reset) begin
        current_state <= A;
    end
    // Transition to next state
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always_comb begin
    case (current_state)
        A: begin
            if (w == 1'b0) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (w == 1'b1) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end
        C: begin
            if (w == 1'b1) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
        end
        D: begin
            if (w == 1'b1) begin
                next_state = A;
            end
            else begin
                next_state = F;
            end
        end
        E: begin
            if (w == 1'b1) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
        end
        F: begin
            if (w == 1'b1) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end
    endcase
end

// Output logic
always_comb begin
    if (current_state == E || current_state == F) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule
