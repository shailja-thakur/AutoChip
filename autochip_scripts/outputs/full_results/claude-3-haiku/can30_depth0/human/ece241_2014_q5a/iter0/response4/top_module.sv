module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [3:0] state;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for Reset release
                if (!areset) begin
                    state <= 1;
                end
            end
            1: begin // Complementing bits
                if (count < 4) begin
                    z <= ~x;
                    count <= count + 1;
                end
                else begin
                    state <= 2;
                    count <= 0;
                end
            end
            2: begin // Waiting for Reset assertion
                if (areset) begin
                    state <= 0;
                end
            end
        endcase
    end
end

endmodule
