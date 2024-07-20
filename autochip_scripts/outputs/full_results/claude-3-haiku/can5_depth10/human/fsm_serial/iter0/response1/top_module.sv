module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] 
    IDLE = 3'd0,
    START = 3'd1,
    DATA = 3'd2,
    STOP = 3'd3,
    ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // start bit detected
                    state <= START;
            end
            START: begin
                bit_count <= 0;
                state <= DATA;
            end
            DATA: begin
                data <= {in, data[7:1]};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7)
                    state <= STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) // wait for stop bit
                    state <= IDLE;
            end
        endcase
    end
end

endmodule
