module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b10; // initial state B
        out <= 1'b1;
    end else begin
        case (state)
            2'b10: begin // state B
                if (in) begin
                    state <= 2'b10; // stay in state B
                    out <= 1'b1;
                end else begin
                    state <= 2'b01; // transition to state A
                    out <= 1'b0;
                end
            end
            2'b01: begin // state A
                if (in) begin
                    state <= 2'b01; // stay in state A
                    out <= 1'b0;
                end else begin
                    state <= 2'b10; // transition to state B
                    out <= 1'b1;
                end
            end
            default: begin
                state <= 2'b10; // default to state B
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
