module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b10;  // Reset to state B
        out <= 0;
    end else begin
        case (state)
            2'b10: begin  // State B
                if (in) begin
                    state <= 2'b10;  // Next state is B
                    out <= 1;  // Output is high
                end else begin
                    state <= 2'b01;  // Next state is A
                    out <= 0;  // Output is low
                end
            end
            2'b01: begin  // State A
                if (in) begin
                    state <= 2'b01;  // Next state is A
                    out <= 0;  // Output is low
                end else begin
                    state <= 2'b10;  // Next state is B
                    out <= 1;  // Output is high
                end
            end
        endcase
    end
end

endmodule
