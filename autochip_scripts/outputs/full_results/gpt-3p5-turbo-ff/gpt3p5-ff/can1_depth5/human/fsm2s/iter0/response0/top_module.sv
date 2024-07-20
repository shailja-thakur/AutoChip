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

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end else begin
                        state <= OFF;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end else begin
                        state <= ON;
                    end
                end
                default: state <= OFF;
            endcase
        end
    end

    // Output assignment
    always @(state) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
