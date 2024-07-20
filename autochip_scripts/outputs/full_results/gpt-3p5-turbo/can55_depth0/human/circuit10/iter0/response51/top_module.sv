module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg d;

always @(posedge clk) begin
    case (state)
        0: begin
            if (a && b) begin
                d <= 1'b0;
                state <= 1'b1;
            end else begin
                d <= a;
                state <= 1'b0;
            end
        end
        1: begin
            if (a && b) begin
                d <= 1'b1;
                state <= 1'b1;
            end else if (a || b) begin
                d <= 1'b0;
                state <= 1'b0;
            end else begin
                d <= a;
                state <= 1'b1;
            end
        end
    endcase
end

assign q = d;
assign state = state;

endmodule
