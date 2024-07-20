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
            state <= STATE_B; // Asynchronously reset to state B
        end
        else begin
            case (state)
                STATE_A: begin
                    if (in == 1'b0) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
                STATE_B: begin
                    if (in == 1'b0) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
        endcase
    end

endmodule
