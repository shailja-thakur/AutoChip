module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter RECEIVE = 3'b010;
parameter STOP = 3'b011;
parameter ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

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
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 0) begin
                    state <= RECEIVE;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            RECEIVE: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    state <= IDLE;
                    done <= 1;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin // Wait for a valid stop bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
