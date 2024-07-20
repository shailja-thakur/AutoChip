module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam STATE_IDLE   = 3'd0;
localparam STATE_START  = 3'd1;
localparam STATE_DATA   = 3'd2;
localparam STATE_STOP   = 3'd3;
localparam STATE_ERROR  = 3'd4;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        done <= 1'b0;
    end
    else begin
        state <= next_state;

        case (state)
            STATE_IDLE: begin
                if (in == 1'b0) begin
                    next_state <= STATE_START;
                    bit_count <= 0;
                    data_register <= 8'b0;
                end
                else begin
                    next_state <= STATE_IDLE;
                end
            end

            STATE_START: begin
                if (in == 1'b0) begin
                    next_state <= STATE_DATA;
                end
                else begin
                    next_state <= STATE_ERROR;
                end
            end

            STATE_DATA: begin
                data_register[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin
                    next_state <= STATE_STOP;
                end
                else begin
                    next_state <= STATE_DATA;
                end
            end

            STATE_STOP: begin
                if (in == 1'b1) begin
                    next_state <= STATE_IDLE;
                    done <= 1'b1;
                end
                else begin
                    next_state <= STATE_ERROR;
                end
            end

            STATE_ERROR: begin
                if (in == 1'b1) begin
                    next_state <= STATE_IDLE;
                end
                else begin
                    next_state <= STATE_ERROR;
                end
            end
        endcase
    end
end

endmodule
