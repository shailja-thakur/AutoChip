module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_INIT = 2'b00;
localparam STATE_COMP = 2'b01;

reg [1:0] state;
reg [31:0] sum;
reg [4:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_INIT;
        sum <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_INIT: begin
                if (~areset) begin
                    state <= STATE_COMP;
                    sum <= 0;
                    count <= 0;
                end
            end
            STATE_COMP: begin
                sum <= sum + {31'b0, x};
                count <= count + 1;
                if (count == 31) begin
                    z <= ~sum[31] ? sum[31:0] : ~sum[31:0] + 1;
                    state <= STATE_INIT;
                end
            end
        endcase
    end
end

endmodule
