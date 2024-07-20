module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPLEMENT = 2'b01;
localparam STATE_DONE = 2'b10;

reg [1:0] state;
reg [7:0] num;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                if (!areset) begin
                    state <= STATE_COMPLEMENT;
                end
            end
            STATE_COMPLEMENT: begin
                num[count] <= x;
                count <= count + 1;
                if (count == 7) begin
                    state <= STATE_DONE;
                    z <= ~num + 1;
                end
            end
            STATE_DONE: begin
                z <= 0;
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
