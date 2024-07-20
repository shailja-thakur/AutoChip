module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    parameter STATE_A = 1'b0;
    parameter STATE_B = 1'b1;

    // Internal state register
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end
        else begin
            case (state)
                STATE_A: begin
                    if (in) begin
                        state <= STATE_A;
                    end
                    else begin
                        state <= STATE_B;
                    end
                end
                STATE_B: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
                default: begin
                    state <= STATE_B;
                end
            endcase
        end
    end

    // Set the output based on the current state
    always @* begin
        if (state == STATE_B) begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
