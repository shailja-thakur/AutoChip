module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define state enumeration
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_type;

    // Define state and state_next signals
    reg state;
    reg state_next;

    // Initialize state register to S
    initial begin
        state <= S;
    end

    // Assign state_next based on input x and current state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S;
        else begin
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
    end

    // Assign output z based on current state
    always @(state) begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule
