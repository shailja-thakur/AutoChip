module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the states
    parameter S = 0;
    parameter S1 = 1;
    parameter S10 = 2;

    // Define the state and next state variables
    reg [1:0] state;
    reg [1:0] state_next;

    // Initialize the state and next state variables
    initial begin
        state <= S;
        state_next <= S;
    end

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            S: begin
                if (x == 1)
                    state_next = S1;
                else
                    state_next = S;
            end
            S1: begin
                if (x == 0)
                    state_next = S10;
                else
                    state_next = S1;
            end
            S10: begin
                if (x == 1)
                    state_next = S1;
                else
                    state_next = S;
            end
            default: state_next = S;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S;
        else
            state <= state_next;
    end

    // Combinational logic for output z
    always @(*) begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule
