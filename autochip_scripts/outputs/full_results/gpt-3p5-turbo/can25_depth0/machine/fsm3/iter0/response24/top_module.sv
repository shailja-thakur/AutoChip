module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;  // reset to state A
    end else begin
        case (state)
            2'b00: begin  // state A
                if (in == 1'b1) begin
                    state <= 2'b01;  // transition to state B
                end else begin
                    state <= 2'b00;  // stay at state A
                end
            end
            2'b01: begin  // state B
                if (in == 1'b1) begin
                    state <= 2'b01;  // stay at state B
                end else begin
                    state <= 2'b10;  // transition to state C
                end
            end
            2'b10: begin  // state C
                if (in == 1'b1) begin
                    state <= 2'b11;  // transition to state D
                end else begin
                    state <= 2'b00;  // transition to state A
                end
            end
            2'b11: begin  // state D
                if (in == 1'b1) begin
                    state <= 2'b01;  // transition to state B
                end else begin
                    state <= 2'b10;  // transition to state C
                end
            end
        endcase
    end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
