module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;

reg [1:0] state;
reg [7:0] result;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        result <= 8'b0;
        count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                if (!areset) begin
                    state <= STATE_COMPUTE;
                end
            end
            STATE_COMPUTE: begin
                if (count == 4'd7) begin
                    z <= ~result[7];
                end
                else begin
                    result <= {result[6:0], x};
                    count <= count + 4'd1;
                end
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
