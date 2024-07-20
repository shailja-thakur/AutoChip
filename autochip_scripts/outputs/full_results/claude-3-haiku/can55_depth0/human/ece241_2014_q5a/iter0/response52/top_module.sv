module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] temp_result;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        bit_count <= 0;
        temp_result <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                bit_count <= 0;
                temp_result <= 0;
                z <= 0;
            end
            COMPUTE: begin
                bit_count <= bit_count + 1;
                temp_result <= {temp_result[6:0], x};
                z <= temp_result[7];
            end
            DONE: begin
                z <= ~temp_result[7] ? temp_result : (~temp_result + 1);
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = COMPUTE;
            end
            else begin
                next_state = IDLE;
            end
        end
        COMPUTE: begin
            if (bit_count == 8) begin
                next_state = DONE;
            end
            else begin
                next_state = COMPUTE;
            end
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
