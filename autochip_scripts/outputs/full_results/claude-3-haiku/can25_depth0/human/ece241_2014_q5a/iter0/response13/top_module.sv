module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
    reg [1:0] state, next_state;
    reg [7:0] accumulator;
    reg [3:0] bit_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            accumulator <= 0;
            bit_count <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (~areset) begin
                        next_state <= CONVERT;
                        accumulator <= 0;
                        bit_count <= 0;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end
                CONVERT: begin
                    accumulator <= (accumulator >> 1) | (x << 7);
                    bit_count <= bit_count + 1;
                    if (bit_count == 8) begin
                        next_state <= DONE;
                        z <= ~accumulator + 1;
                    end
                    else begin
                        next_state <= CONVERT;
                    end
                end
                DONE: begin
                    if (areset) begin
                        next_state <= IDLE;
                    end
                    else begin
                        next_state <= DONE;
                    end
                end
                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end

endmodule
