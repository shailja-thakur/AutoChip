module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00;
parameter CONVERT = 2'b01;
parameter DONE = 2'b10;

reg [1:0] state;
reg [7:0] result;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        result <= 8'b0;
        count <= 4'b0;
        z <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                    result <= 8'b0;
                    count <= 4'b0;
                end
            end
            CONVERT: begin
                result <= {result[6:0], x};
                count <= count + 1;
                if (count == 4'b1000) begin
                    state <= DONE;
                    z <= ~result + 1;
                end
            end
            DONE: begin
                if (areset) begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
