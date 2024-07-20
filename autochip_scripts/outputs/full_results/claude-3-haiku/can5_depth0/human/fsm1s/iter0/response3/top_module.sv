module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // State register
    reg state;

    // Next state logic
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

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b1;
        end
        else begin
            case (state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b1;
            endcase
        end
    end

endmodule
