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
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin
                if (j) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b00;
                end
            end
            2'b01: begin
                if (k) begin
                    state <= 2'b00;
                end else begin
                    state <= 2'b01;
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        2'b00: out = 1'b0;
        2'b01: out = 1'b1;
    endcase
end

endmodule
