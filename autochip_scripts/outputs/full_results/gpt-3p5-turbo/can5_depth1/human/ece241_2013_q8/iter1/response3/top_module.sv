module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    reg [1:0] state, next_state;

    always @(posedge clk or negedge aresetn)
    begin
        if (~aresetn)
            state <= 2'd0;
        else
            state <= next_state;
    end

    always @(state, x)
    begin
        case(state)
            2'd0: // State S0
                if (x == 1'b1)
                    next_state <= 2'd1; // Move to state S1
                else
                    next_state <= 2'd0; // Remain in state S0
            2'd1: // State S1
                if (x == 1'b0)
                    next_state <= 2'd2; // Move to state S2
                else
                    next_state <= 2'd1; // Remain in state S1
            2'd2: // State S2
                if (x == 1'b1)
                    next_state <= 2'd1; // Move to state S1
                else
                    next_state <= 2'd0; // Remain in state S0
        endcase
    end

    always @(posedge clk or negedge aresetn)
    begin
        if (~aresetn)
            z <= 1'b0;
        else
        begin
            case(state)
                2'd2: // State S2
                    z <= 1'b1; // Assert output when in state S2
                default: // Otherwise
                    z <= 1'b0; // Deassert output
            endcase
        end
    end
endmodule
