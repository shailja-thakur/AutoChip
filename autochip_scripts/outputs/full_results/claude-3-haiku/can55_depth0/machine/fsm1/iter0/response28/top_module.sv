module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State register
    reg state;
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

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
            endcase
        end
    end

    // Output logic
    always @(*) begin
        if (state == STATE_B) begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
