module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        if (state == 2'b00) begin
            if (j) begin
                state <= 2'b01;
            end else begin
                state <= 2'b00;
            end
        end else begin
            if (k) begin
                state <= 2'b00;
            end else begin
                state <= 2'b01;
            end
        end
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
