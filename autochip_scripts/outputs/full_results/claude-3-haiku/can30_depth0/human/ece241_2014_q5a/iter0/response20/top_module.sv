module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00;
parameter COMPUTE = 2'b01;
parameter COMPLETE = 2'b10;

reg [1:0] state;
reg [7:0] temp_sum;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        temp_sum <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                    temp_sum <= 0;
                    bit_count <= 0;
                end
            end
            COMPUTE: begin
                temp_sum <= {temp_sum[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= COMPLETE;
                    z <= ~temp_sum + 1;
                end
            end
            COMPLETE: begin
                if (areset) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
