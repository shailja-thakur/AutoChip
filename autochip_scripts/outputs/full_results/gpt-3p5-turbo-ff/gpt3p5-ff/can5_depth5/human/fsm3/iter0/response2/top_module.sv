module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to state A
        end else begin
            case(state)
                2'b00: begin // State A
                    if (in) begin
                        state <= 2'b01; // Next state: B
                    end else begin
                        state <= 2'b00; // Next state: A
                    end
                    out <= 1'b0; // Output: 0
                end
                2'b01: begin // State B
                    if (in) begin
                        state <= 2'b01; // Next state: B
                    end else begin
                        state <= 2'b10; // Next state: C
                    end
                    out <= 1'b0; // Output: 0
                end
                2'b10: begin // State C
                    if (in) begin
                        state <= 2'b11; // Next state: D
                    end else begin
                        state <= 2'b00; // Next state: A
                    end
                    out <= 1'b0; // Output: 0
                end
                2'b11: begin // State D
                    if (in) begin
                        state <= 2'b10; // Next state: C
                    end else begin
                        state <= 2'b01; // Next state: B
                    end
                    out <= 1'b1; // Output: 1
                end
            endcase
        end
    end
endmodule
