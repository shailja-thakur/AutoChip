module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 2'b0;
    else begin
        case (state)
            2'b0: begin
                if (j)
                    state <= 2'b1;
                else
                    state <= 2'b0;
            end
            2'b1: begin
                if (k)
                    state <= 2'b0;
                else
                    state <= 2'b1;
            end
        endcase
    end
end

assign out = (state == 2'b1) ? 1'b1 : 1'b0;

endmodule
