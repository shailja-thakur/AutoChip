module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definitions
parameter IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;

// Internal registers
reg [7:0] input_num, result;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 0;
        result <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == CONVERT) begin
            input_num <= {input_num[6:0], x};
            bit_count <= bit_count + 1;
            if (bit_count == 7) begin
                result <= ~input_num + 1;
                next_state <= DONE;
            end
            else begin
                next_state <= CONVERT;
            end
        end
        else if (state == DONE) begin
            z <= result[0];
            result <= {1'b0, result[7:1]};
            if (result == 0) begin
                next_state <= IDLE;
            end
            else begin
                next_state <= DONE;
            end
        end
        else begin // IDLE
            next_state <= CONVERT;
        end
    end
end

endmodule
