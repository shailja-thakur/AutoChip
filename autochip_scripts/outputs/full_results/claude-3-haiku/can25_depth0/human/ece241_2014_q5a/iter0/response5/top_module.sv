module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'd0,
                 CONVERT = 2'd1,
                 COMPLETE = 2'd2;

reg [1:0] state;
reg [7:0] input_num;
reg [7:0] complement;
integer i;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z <= 0;
        input_num <= 0;
        complement <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                input_num[0] <= x;
                for (i = 7; i > 0; i = i - 1) begin
                    input_num[i] <= input_num[i-1];
                end
                complement <= ~input_num + 1;
                z <= complement[0];
                if (areset) begin
                    state <= COMPLETE;
                end
            end
            COMPLETE: begin
                z <= 0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
