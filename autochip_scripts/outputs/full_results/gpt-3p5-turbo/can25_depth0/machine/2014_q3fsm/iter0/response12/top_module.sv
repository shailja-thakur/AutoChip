module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define state enumeration
typedef enum logic [3:0] {
    A, B, C, S10, S11, S20, S21, S22
} state_type;

// Define current state and next state variables
reg [3:0] state, next_state;

// Assign initial state
initial begin
    state <= A;
end

// Assign next_state based on current state logic
always @(*) begin
    case(state)
        A: begin
            if(s) next_state = B;
            else next_state = A;
        end
        B, C: begin
            if(w) next_state = S11;
            else next_state = S10;
        end
        S10: begin
            if(w) next_state = S21;
            else next_state = S20;
        end
        S11: begin
            if(w) next_state = S22;
            else next_state = S21;
        end
        S20: next_state = B;
        S21: begin
            if(w) next_state = C;
            else next_state = B;
        end
        S22: begin
            if(w) next_state = B;
            else next_state = C;
        end
        default: next_state = state;
    endcase
end

// Assign current state based on next_state
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Output logic based on current state
always @(state) begin
    case(state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        default: z = 1;
    endcase
end

endmodule
