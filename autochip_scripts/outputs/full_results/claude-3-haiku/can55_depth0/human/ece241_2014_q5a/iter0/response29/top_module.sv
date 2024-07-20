module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] neg_count;
reg state;

localparam S_CONVERT = 1'b0;
localparam S_DONE = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        neg_count <= 0;
        state <= S_CONVERT;
        z <= 0;
    end
    else begin
        case (state)
            S_CONVERT: begin
                if (count == 8'b11111111) begin
                    state <= S_DONE;
                    z <= ~neg_count[0] + 1;
                end
                else begin
                    count <= count + 1;
                    neg_count <= {neg_count[6:0], x};
                    z <= ~neg_count[0] + 1;
                end
            end
            S_DONE: begin
                z <= 0;
            end
        endcase
    end
end

endmodule
