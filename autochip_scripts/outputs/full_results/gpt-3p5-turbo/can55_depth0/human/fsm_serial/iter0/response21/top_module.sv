module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg [7:0] data;
reg [2:0] bit_count;

parameter IDLE = 0;
parameter START = 1;
parameter RECEIVE = 2;
parameter STOP = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 8'b0;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (!in) begin
                    state <= START;
                    bit_count <= 0;
                    data <= 8'b0;
                end
            end
            START: begin
                if (bit_count < 8) begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end else begin
                    state <= RECEIVE;
                    bit_count <= 0;
                end
            end
            RECEIVE: begin
                if (bit_count < 7) begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end else begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (in) begin
                    if (bit_count == 0) begin
                        state <= IDLE;
                        done <= 1;
                    end else begin
                        state <= START;
                    end
                end
            end
        endcase
    end
end

endmodule
