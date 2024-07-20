module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the state codes
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    parameter E = 2'b11;  // E will not be used as a state
    parameter F = 2'b01;  // F will not be used as a state

    // Define the state registers
    reg [1:0] state_reg;
    reg [1:0] next_state;

    // Define the initial state
    initial begin
        state_reg <= A;
    end

    // Determine the next state based on the current state and input
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
        endcase
    end

    // Update the state registers on positive edge of clk
    always @(posedge clk) begin
        if (reset)
            state_reg <= A;
        else
            state_reg <= next_state;
    end

    // Determine the output based on the current state
    always @(state_reg) begin
        case (state_reg)
            E: z <= 1'b1;
            default: z <= 1'b0;
        endcase
    end

endmodule
