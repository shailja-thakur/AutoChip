module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define states as enum
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_t;

// Define state registers
reg [1:0] current_state, next_state;

// Assign current state to next state at positive edge of the clock
always @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Assign next state and output based on the current state and input
always @(*) begin
    case (current_state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (!in)
                next_state = C;
            else
                next_state = B;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (!in)
                next_state = C;
            else
                next_state = B;
        end
    endcase
    
    case (current_state)
        A: out = 1'b0;
        B: out = 1'b0;
        C: out = 1'b0;
        D: out = 1'b1;
    endcase
end

endmodule
