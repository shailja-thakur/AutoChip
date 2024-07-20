module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // state A
        end
        else begin
            case (state)
                2'b00: // state A
                    if (in) begin
                        state <= 2'b01; // state B
                    end
                    else begin
                        state <= 2'b00; // state A
                    end
                2'b01: // state B
                    if (in) begin
                        state <= 2'b01; // state B
                    end
                    else begin
                        state <= 2'b10; // state C
                    end
                2'b10: // state C
                    if (in) begin
                        state <= 2'b11; // state D
                    end
                    else begin
                        state <= 2'b00; // state A
                    end
                2'b11: // state D
                    if (in) begin
                        state <= 2'b01; // state B
                    end
                    else begin
                        state <= 2'b10; // state C
                    end
            endcase
        end
    end

    always @(*) begin
        if (state == 2'b11) begin // state D
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
