module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] WAIT_START = 3'd0,
                 RECEIVE_DATA = 3'd1,
                 WAIT_STOP = 3'd2,
                 DONE = 3'd3;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        data_reg <= 0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= RECEIVE_DATA;
                    bit_count <= 0;
                end
            end
            RECEIVE_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= WAIT_START;
                end
                else begin // Wait for stop bit
                    done <= 1'b0;
                end
            end
            DONE: begin
                state <= WAIT_START;
                done <= 1'b1;
            end
            default: state <= WAIT_START;
        endcase
    end
end

endmodule
