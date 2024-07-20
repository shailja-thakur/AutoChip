module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [1:0] state;

localparam IDLE = 2'd0;
localparam CONVERT = 2'd1;
localparam COMPLETE = 2'd2;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                z <= ~x;
                count <= count + 1;
                if (count == 8'd255) begin
                    state <= COMPLETE;
                end
            end
            COMPLETE: begin
                z <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
