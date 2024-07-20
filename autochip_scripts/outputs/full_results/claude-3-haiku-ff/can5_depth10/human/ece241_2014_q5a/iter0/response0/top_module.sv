module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    WAIT = 2'b00,
    COMPLEMENT = 2'b01,
    DONE = 2'b10;

reg [1:0] state, next_state;
reg [7:0] temp_sum;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAIT;
        temp_sum <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        temp_sum <= next_temp_sum;
        z <= next_z;
    end
end

always @(*) begin
    next_state = state;
    next_temp_sum = temp_sum;
    next_z = 1'b0;

    case (state)
        WAIT: begin
            if (~areset) begin
                next_state = COMPLEMENT;
                next_temp_sum = 8'b0;
            end
        end
        COMPLEMENT: begin
            next_temp_sum = {temp_sum[6:0], x};
            next_z = ~temp_sum[7] ? temp_sum[7:0] : ~temp_sum + 1'b1;
            if (areset) begin
                next_state = DONE;
            end
        end
        DONE: begin
            next_z = ~temp_sum + 1'b1;
        end
        default: begin
            next_state = WAIT;
        end
    endcase
end

endmodule
