module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// State encoding
typedef enum logic [2:0] {
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100
} state_t;

state_t state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end

        B: begin
            if (x == 1'b0) begin
                next_state = B;
            end else begin
                next_state = E;
            end
        end

        C: begin
            if (x == 1'b0) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end

        D: begin
            if (x == 1'b0) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end

        E: begin
            if (x == 1'b0) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end

        default: begin
            next_state = A; // Default to initial state in case of unknown state
        end
    endcase
end

// State flip-flops and reset logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A; // Initialize to state A on reset
    end else begin
        state <= next_state; // Update state on clock edge
    end
end

// Output logic
always @(*) begin
    case (state)
        D, E: z = 1'b1; // Output is high when state is D or E
        default: z = 1'b0; // Output is low for other states
    endcase
end

endmodule
