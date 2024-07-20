module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, FINISH = 2'b11;
reg [1:0] state, next_state;
reg [7:0] temp_result;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        temp_result <= 8'h00;
        bit_count <= 4'h0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                temp_result <= 8'h00;
                bit_count <= 4'h0;
                z <= 1'b0;
            end
            CONVERT: begin
                temp_result <= {temp_result[6:0], x};
                bit_count <= bit_count + 4'h1;
                z <= ~temp_result[7];
            end
            FINISH: begin
                z <= ~temp_result[7];
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
            end
            else begin
                next_state = IDLE;
            end
        end
        CONVERT: begin
            if (bit_count == 4'h8) begin
                next_state = FINISH;
            end
            else begin
                next_state = CONVERT;
            end
        end
        FINISH: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
