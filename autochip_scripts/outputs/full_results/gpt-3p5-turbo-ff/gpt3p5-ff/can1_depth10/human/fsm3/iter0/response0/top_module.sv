module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // Reset to state A
        else begin
            case (state)
                2'b00: begin // State A
                    if (in)
                        state <= 2'b01; // Next state: B
                    else
                        state <= 2'b00; // Next state: A
                    out_reg <= 1'b0; // Output: 0
                end

                2'b01: begin // State B
                    if (in)
                        state <= 2'b01; // Next state: B
                    else
                        state <= 2'b10; // Next state: C
                    out_reg <= 1'b0; // Output: 0
                end

                2'b10: begin // State C
                    if (in)
                        state <= 2'b11; // Next state: D
                    else
                        state <= 2'b00; // Next state: A
                    out_reg <= 1'b0; // Output: 0
                end

                2'b11: begin // State D
                    if (in)
                        state <= 2'b10; // Next state: C
                    else
                        state <= 2'b01; // Next state: B
                    out_reg <= 1'b1; // Output: 1
                end
            endcase
        end
    end

    assign out = out_reg;

endmodule
