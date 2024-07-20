module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg [1:0] state;

parameter OFF = 0;
parameter ON = 1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end else if (state == OFF) begin
        if (j) begin
            state <= ON;
        end else begin
            state <= OFF;
        end
    end else begin // state == ON
        if (k) begin
            state <= OFF;
        end else begin
            state <= ON;
        end
    end
end

always @(state) begin
    case (state)
        OFF: out = 0;
        ON: out = 1;
    endcase
end

endmodule
