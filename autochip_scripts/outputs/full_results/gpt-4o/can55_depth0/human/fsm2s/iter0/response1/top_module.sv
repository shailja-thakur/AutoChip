module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            OFF: begin
                out = 1'b0;
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                out = 1'b1;
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
                out = 1'b0;
            end
        endcase
    end
endmodule
