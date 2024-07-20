module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Define the state variable
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_B;
            out <= 1'b1;
        end
        else begin
            case (state)
                STATE_B: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                    out <= 1'b1;
                end
                STATE_A: begin
                    if (in) begin
                        state <= STATE_A;
                    end
                    else begin
                        state <= STATE_B;
                    end
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule
