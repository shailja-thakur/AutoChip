module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter STATE_INIT = 0, STATE_COMP = 1;
reg state;
reg [7:0] num;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_INIT;
        num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_INIT: begin
                if (x) begin
                    num <= num | (1 << count);
                end
                count <= count + 1;
                if (x == 0 && count == 7) begin
                    state <= STATE_COMP;
                    count <= 0;
                end
            end
            STATE_COMP: begin
                if (count == 0) begin
                    z <= ~num + 1;
                end
                count <= count + 1;
                if (count == 8) begin
                    state <= STATE_INIT;
                    num <= 0;
                end
            end
        endcase
    end
end

endmodule
