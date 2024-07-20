module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0;
        end else begin
            case (state)
                2'b00: begin // OFF state
                    if (j) begin
                        state <= 2'b01; // Transition from OFF to ON
                    end else begin
                        state <= 2'b00; // Stay in OFF state
                    end
                end
                2'b01: begin // ON state
                    if (k) begin
                        state <= 2'b00; // Transition from ON to OFF
                    end else begin
                        state <= 2'b01; // Stay in ON state
                    end
                end
                default: state <= 2'b0; // Default case for safety
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out_reg = 1'b0; // OFF state, out = 0
            2'b01: out_reg = 1'b1; // ON state, out = 1
            default: out_reg = 1'b0; // Default case for safety
        endcase
    end

    assign out = out_reg;

endmodule
