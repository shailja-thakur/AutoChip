module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: // State A
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b00;
                end
            2'b01: // State B
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b10;
                end
            2'b10: // State C
                if (in) begin
                    state <= 2'b11;
                end else begin
                    state <= 2'b00;
                end
            2'b11: // State D
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b10;
                end
        endcase
    end
end

always @(state) begin
    if (state == 2'b11) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
