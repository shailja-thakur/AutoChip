module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00;
parameter CALC = 2'b01;
parameter DONE = 2'b10;

reg [1:0] state;
reg [7:0] num;
reg [3:0] count;

always @(posedge clk or negedge areset) begin
    if (!areset) begin
        state <= IDLE;
        num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= CALC;
                    num <= 1;
                    count <= 1;
                end
            end
            CALC: begin
                num <= {num[6:0], x};
                count <= count + 1;
                if (count == 8) begin
                    state <= DONE;
                    z <= ~num + 1;
                end
            end
            DONE: begin
                if (areset) begin
                    state <= IDLE;
                    num <= 0;
                    count <= 0;
                    z <= 0;
                end
            end
            default: begin
                state <= IDLE;
                num <= 0;
                count <= 0;
                z <= 0;
            end
        endcase
    end
end

endmodule
