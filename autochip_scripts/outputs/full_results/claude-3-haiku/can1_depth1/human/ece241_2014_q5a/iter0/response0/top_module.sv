module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 8'b0;
        complement <= 8'b0;
        state <= 1'b0;
    end
    else begin
        if (state == 1'b0) begin
            if (x) begin
                complement <= complement + 1'b1;
            end
            count <= count + 1'b1;
            if (count == 8'b11111111) begin
                state <= 1'b1;
            end
        end
        else begin
            z <= ~complement[0];
            complement <= {1'b0, complement[7:1]};
            if (complement == 8'b0) begin
                state <= 1'b0;
                count <= 8'b0;
            end
        end
    end
end

endmodule
