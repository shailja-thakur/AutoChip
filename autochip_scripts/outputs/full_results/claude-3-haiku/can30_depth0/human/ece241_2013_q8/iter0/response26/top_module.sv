module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the 3 states of the FSM
    parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (x) next_state = S1;
                else next_state = IDLE;
            end
            S1: begin
                if (x) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (x) next_state = S1;
                else next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            IDLE: z = 1'b0;
            S1: z = 1'b0;
            S2: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register
    always @(posedge clk, negedge aresetn) begin
        if (~aresetn) state <= IDLE;
        else state <= next_state;
    end

endmodule
