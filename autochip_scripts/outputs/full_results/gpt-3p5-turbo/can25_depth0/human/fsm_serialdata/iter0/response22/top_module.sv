module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] shift_reg;
reg start_bit, stop_bit;
reg done_reg;
wire in_sync;

parameter IDLE = 3'b000;
parameter RECEIVE_START = 3'b001;
parameter RECEIVE_DATA = 3'b010;
parameter RECEIVE_STOP = 3'b011;
parameter DONE = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 8'b0;
        start_bit <= 1'b0;
        stop_bit <= 1'b0;
        done_reg <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= RECEIVE_START;
                    start_bit <= 1'b1;
                end
            end

            RECEIVE_START: begin
                if (in == 1'b0) begin
                    state <= RECEIVE_DATA;
                    shift_reg <= in;
                end
            end

            RECEIVE_DATA: begin
                if (in_sync) begin
                    shift_reg <= {shift_reg[6:0], in};
                end

                if (in_sync && (shift_reg[7] == 1'b1)) begin
                    state <= RECEIVE_STOP;
                    stop_bit <= 1'b1;
                end
            end

            RECEIVE_STOP: begin
                if (in == 1'b1) begin
                    state <= DONE;
                end
            end

            DONE: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done_reg <= 1'b0;
                end
            end
        endcase
    end
end

assign in_sync = (start_bit == 1'b1);

always @(posedge clk) begin
    if (state == DONE && done_reg == 1'b0) begin
        done_reg <= 1'b1;
    end else if (state != DONE) begin
        done_reg <= 1'b0;
    end
end

assign done = done_reg;
assign out_byte = shift_reg;

endmodule
