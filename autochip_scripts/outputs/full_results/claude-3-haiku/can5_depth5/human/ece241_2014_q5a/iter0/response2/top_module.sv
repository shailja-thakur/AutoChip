module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00;
parameter COMPUTE = 2'b01;
parameter DONE = 2'b10;

reg [1:0] state;
reg [7:0] num;
reg [3:0] count;

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        state <= IDLE;
        num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    num <= 8'b11111111;
                    count <= 0;
                    state <= COMPUTE;
                end
            end
            COMPUTE: begin
                num[count] <= ~x;
                count <= count + 1;
                if (count == 7) begin
                    z <= num[0];
                    state <= DONE;
                end
            end
            DONE: begin
                if (x) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
