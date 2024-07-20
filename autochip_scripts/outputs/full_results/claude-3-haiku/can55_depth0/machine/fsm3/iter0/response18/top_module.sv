module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state; // 2-bit state register

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // reset state to A
        end
        else begin
            case (state)
                2'b00: // state A
                    if (in) begin
                        state <= 2'b01; // next state B
                    end
                    else begin
                        state <= 2'b00; // stay in state A
                    end
                2'b01: // state B
                    if (in) begin
                        state <= 2'b01; // stay in state B
                    end
                    else begin
                        state <= 2'b10; // next state C
                    end
                2'b10: // state C
                    if (in) begin
                        state <= 2'b11; // next state D
                    end
                    else begin
                        state <= 2'b00; // next state A
                    end
                2'b11: // state D
                    if (in) begin
                        state <= 2'b01; // next state B
                    end
                    else begin
                        state <= 2'b10; // next state C
                    end
            endcase
        end
    end

    always @* begin
        out = (state == 2'b11); // output is 1 when in state D
    end

endmodule
