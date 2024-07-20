module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 1'b0, CONVERT = 1'b1;
reg state;
reg [7:0] num, complement;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 8'b0;
        complement <= 8'b0;
        count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                    count <= 4'b0;
                end
            end
            CONVERT: begin
                num[count] <= x;
                if (count == 4'd7) begin
                    complement <= ~num + 1'b1;
                    count <= 4'b0;
                end
                else begin
                    count <= count + 1'b1;
                end
                z <= complement[count];
            end
        endcase
    end
end

endmodule
