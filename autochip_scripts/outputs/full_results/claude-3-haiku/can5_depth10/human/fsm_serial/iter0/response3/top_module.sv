module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERROR = 3'b100;
reg [2:0] state;
reg [3:0] count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // start bit detected
                    state <= START;
                    count <= 0;
                end
            end
            START: begin
                if (count == 4'd9) begin // start bit and 8 data bits received
                    state <= DATA;
                    count <= 0;
                end else begin
                    count <= count + 1;
                    data_reg[count-1] <= in; // shift in data bits
                end
            end
            DATA: begin
                if (count == 4'd0) begin // stop bit expected
                    if (in == 1'b1) begin // stop bit received
                        state <= IDLE;
                        done <= 1'b1;
                    end else begin
                        state <= ERROR;
                    end
                end else begin
                    count <= count - 1;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // wait for stop bit
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
