module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE     = 3'b000;
localparam START_BIT= 3'b001;
localparam DATA_BIT = 3'b010;
localparam STOP_BIT = 3'b011;
localparam WAIT_STOP= 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state     <= IDLE;
        bit_count <= 0;
        data_reg  <= 0;
        done      <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // start bit detected
                    state     <= START_BIT;
                    bit_count <= 0;
                    data_reg  <= 0;
                end
            end

            START_BIT: begin
                if (in == 0) begin // valid start bit
                    state     <= DATA_BIT;
                    bit_count <= 0;
                end else begin // invalid start bit
                    state <= WAIT_STOP;
                end
            end

            DATA_BIT: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1) begin // valid stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin // invalid stop bit
                    state <= WAIT_STOP;
                end
            end

            WAIT_STOP: begin
                if (in == 1) begin // found stop bit
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
