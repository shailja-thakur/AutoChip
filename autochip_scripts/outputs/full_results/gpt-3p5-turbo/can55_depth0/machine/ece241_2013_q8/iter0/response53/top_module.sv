module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define possible states
typedef enum logic [1:0] {
    S,
    S1,
    S10
} state_t;

// Declare state register and next state variable
reg [1:0] state_reg, state_next;

// Always block for synchronous reset and state transition
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        // Asynchronous reset
        state_reg <= S;
    end
    else begin
        // State transition logic
        case (state_reg)
            S: begin      // When state is S
                if (x == 1'b0)
                    state_next = S;
                else if (x == 1'b1)
                    state_next = S1;
            end
            S1: begin     // When state is S1
                if (x == 1'b0)
                    state_next = S10;
                else if (x == 1'b1)
                    state_next = S1;
            end
            S10: begin    // When state is S10
                if (x == 1'b0)
                    state_next = S;
                else if (x == 1'b1)
                    state_next = S1;
            end
            default: state_next = S;
        endcase
        state_reg <= state_next;
    end
end

// Output logic
always @(state_reg) begin
    case (state_reg)
        S, S1: z = 1'b0;
        S10: z = x;
        default: z = 1'b0;
    endcase
end

endmodule
