module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Define the state register
    reg state;

    // Define the next state logic
    always @(posedge clk) begin
        if (reset) begin
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
            endcase
        end
    end

    // Define the output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                out = 1'b0;
            end
            STATE_B: begin
                out = 1'b1;
            end
        endcase
    end

endmodule
