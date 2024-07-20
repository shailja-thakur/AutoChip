module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0; // Reset to state OFF
        end else begin
            case (state)
                2'b00: begin // OFF state
                    if (j)
                        state <= 2'b01; // Transition to ON state
                end
                2'b01: begin // ON state
                    if (!j && k)
                        state <= 2'b10; // Transition to OFF state
                end
                2'b10: begin // OFF state
                    if (j)
                        state <= 2'b01; // Transition to ON state
                end
                default: state <= 2'b0; // Reset state to OFF in case of unknown state
            endcase
        end
    end

    always @* begin
        case (state)
            2'b00: out = 1'b0; // OFF state, out=0
            2'b01: out = 1'b1; // ON state, out=1
            2'b10: out = 1'b1; // OFF state, out=1
            default: out = 1'b0; // Reset state to OFF in case of unknown state
        endcase
    end

endmodule
