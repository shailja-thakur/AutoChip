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
                if (count < 8) begin
                    complement[count] <= ~x;
                    count <= count + 1;
                    z <= ~x;
                end
                else begin
                    complement <= complement + 1;
                    state <= 2;
                    z <= complement[7];
                end
            end
            2: begin // Output 2's complement
                if (count > 0) begin
                    count <= count - 1;
                    z <= complement[count-1];
                end
                else begin
                    state <= 0;
                end
            end
        endcase
    end
end

endmodule
