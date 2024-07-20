module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'd0;
        count <= 3'd0;
    end else begin
        case(state)
            2'd0: begin
                if (s == 1'b1) begin
                    state <= 2'd1;
                end
            end
            2'd1: begin
                count <= count + 1;
                if (count == 3'd2) begin
                    if (w == 1'b1) begin
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                end else begin
                    z <= 1'b0;
                end
                if (count == 3'd5) begin
                    count <= 3'd0;
                    state <= 2'd0;
                end
            end
        endcase
    end
end

endmodule
