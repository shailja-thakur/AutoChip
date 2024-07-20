module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;

// State encoding:
// state 0: Initial state
// state 1: State after input "1" is detected
// state 2: State after input "10" is detected
// state 3: State after input "101" is detected

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 0;
        z <= 0;
    end else begin
        case(state)
            0: begin // Initial state
                if (x == 1'b1)
                    state <= 1;
                else
                    state <= 0;
            end
            1: begin // State after input "1" is detected
                if (x == 1'b0)
                    state <= 2;
                else
                    state <= 1;
            end
            2: begin // State after input "10" is detected
                if (x == 1'b1)
                    state <= 3;
                else if (x == 1'b0)
                    state <= 2;
                else
                    state <= 0;
            end
            3: begin // State after input "101" is detected
                if (x == 1'b0)
                    state <= 2;
                else
                    state <= 3;
            end
            default:   // Default case
                state <= 0;
        endcase

        if (state == 3)
            z <= 1;
        else
            z <= 0;
    end
end

endmodule
