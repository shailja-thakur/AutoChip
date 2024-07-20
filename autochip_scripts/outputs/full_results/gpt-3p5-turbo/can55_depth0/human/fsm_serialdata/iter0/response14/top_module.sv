module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_byte <= 8'b0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                end
            end
            START_BIT: begin
                state <= DATA_BITS;
            end
            DATA_BITS: begin
                data_byte <= {data_byte[6:0], in};
                if (data_byte == 8'b11111111) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done <= 1;
                end
                state <= IDLE; // wait for next start bit
            end
        endcase
    end
end

assign out_byte = data_byte;

endmodule
