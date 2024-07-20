module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam IDLE     = 2'b00;
localparam FOUND_1  = 2'b01;
localparam FOUND_11 = 2'b10;
localparam FOUND_110 = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (data == 1) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 0;
        end
        FOUND_1: begin
            if (data == 0) begin
                next_state = FOUND_11;
            end
            else begin
                next_state = FOUND_1;
            end
            start_shifting = 0;
        end
        FOUND_11: begin
            if (data == 0) begin
                next_state = FOUND_110;
            end
            else begin
                next_state = FOUND_1;
            end
            start_shifting = 0;
        end
        FOUND_110: begin
            if (data == 1) begin
                next_state = FOUND_1;
                start_shifting = 1;
            end
            else begin
                next_state = IDLE;
                start_shifting = 0;
            end
        end
        default: begin
            next_state = IDLE;
            start_shifting = 0;
        end
    endcase
end

endmodule
