module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    parameter OFF = 1'b0;
    parameter ON = 1'b1;

    // Define state register
    reg state;
    reg next_state;

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF;
        endcase
    end

    // Output assignment
    always @(state) begin
        out = state;
    end

endmodule
