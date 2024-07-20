module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        state <= 0;
        z <= 0;
    end
    else begin
        case (state)
            0: begin // Reset state
                if (!areset) begin
                    state <= 1;
                end
            end
            1: begin // Compute 2's complement
                if (count == 0) begin
                    complement <= 0;
                end
                else begin
                    complement <= complement >> 1;
                    if (x) begin
                        complement[7] <= 1;
                    end
                    else begin
                        complement[7] <= 0;
                    end
                end
                if (count == 7) begin
                    z <= ~complement + 1;
                    state <= 0;
                end
                else begin
                    count <= count + 1;
                end
            end
        endcase
    end
end

endmodule
