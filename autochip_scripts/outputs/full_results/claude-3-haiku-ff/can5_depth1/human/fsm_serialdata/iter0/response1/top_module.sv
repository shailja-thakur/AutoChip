module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, WAIT = 3'b100;
reg [2:0] state, next_state;
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
        state <= next_state;
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (in == 0) begin
                    next_state <= DATA;
                end
                else begin
                    next_state <= WAIT;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    next_state <= STOP;
                end
                else begin
                    next_state <= DATA;
                end
            end
            STOP: begin
                if (in == 1) begin
                    next_state <= IDLE;
                    done <= 1;
                    out_byte <= data_reg;
                end
                else begin
                    next_state <= WAIT;
                end
            end
            WAIT: begin
                if (in == 1) begin
                    next_state <= IDLE;
                end
                else begin
                    next_state <= WAIT;
                end
            end
        endcase
    end
end

endmodule
