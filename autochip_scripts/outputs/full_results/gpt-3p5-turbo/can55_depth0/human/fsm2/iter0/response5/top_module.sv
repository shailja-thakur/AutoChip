module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b0;
        else begin
            case (state)
                2'b00: begin // OFF
                    if (j)
                        state <= 2'b01; // Go to ON state
                    else
                        state <= 2'b00; // Remain in OFF state
                end

                2'b01: begin // ON
                    if (k)
                        state <= 2'b00; // Go to OFF state
                    else
                        state <= 2'b01; // Remain in ON state
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out = 1'b0; // OFF state, out = 0
            2'b01: out = 1'b1; // ON state, out = 1
        endcase
    end

endmodule
