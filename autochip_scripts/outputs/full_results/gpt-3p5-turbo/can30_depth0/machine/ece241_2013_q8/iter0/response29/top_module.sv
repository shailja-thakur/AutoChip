module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states
    enum logic [1:0] state;
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S10 = 2'b10;

    // Define next state logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S; // Reset state to S
        else begin
            case (state)
                S: begin
                    if (x == 1)
                        state <= S1;
                end
                S1: begin
                    if (x == 0)
                        state <= S10;
                end
                S10: begin
                    if (x == 1)
                        state <= S1;
                end
                default: state <= S; // Default state is S
            endcase
        end
    end

    // Define output logic
    always_comb begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule
