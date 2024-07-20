module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] state;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 8'b0;
        complement <= 8'b0;
    end
    else begin
        case (state)
            8'b0: begin
                if (x) begin
                    complement <= complement - 1;
                end
                else begin
                    complement <= complement + 1;
                end
                state <= state + 1;
            end
            8'd1: begin
                if (x) begin
                    complement <= complement ^ 8'b11111111;
                    complement <= complement + 1;
                end
                state <= state + 1;
            end
            8'd2: begin
                z <= complement[0];
                complement <= {1'b0, complement[7:1]};
                if (complement == 8'b0) begin
                    state <= 8'b0;
                end
                else begin
                    state <= state + 1;
                end
            end
            default: begin
                z <= complement[0];
                complement <= {1'b0, complement[7:1]};
                if (complement == 8'b0) begin
                    state <= 8'b0;
                end
                else begin
                    state <= state + 1;
                end
            end
        endcase
    end
end

endmodule
