module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0;
            out <= 0;
        end else begin
            case(state)
                2'b00: begin // OFF state
                    if (j) begin
                        state <= 2'b01; // Transition to ON state
                        out <= 0;
                    end else begin
                        state <= 2'b00; // Remain in OFF state
                        out <= 0;
                    end
                end
                2'b01: begin // ON state
                    if (k) begin
                        state <= 2'b00; // Transition to OFF state
                        out <= 1;
                    end else begin
                        state <= 2'b01; // Remain in ON state
                        out <= 1;
                    end
                end
                
                default: begin
                    state <= 2'b0;
                    out <= 0;
                end
            endcase
        end
    end

endmodule
