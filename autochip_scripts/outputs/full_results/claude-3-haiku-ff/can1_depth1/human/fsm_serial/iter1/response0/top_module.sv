module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter RECEIVE = 3'b010;
parameter STOP = 3'b011;
parameter WAIT_STOP = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
                else begin
                    done <= 0;
                end
            end
            START: begin
                if (in == 1'b0) begin // Start bit confirmed
                    state <= RECEIVE;
                end
                else begin // Start bit not detected, go back to IDLE
                    state <= IDLE;
                end
            end
            RECEIVE: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // 8 data bits received
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin // Stop bit not detected, go to wait for stop
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_STOP;
                end
            end
        endcase
    end
end

endmodule
