module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        state <= next_state;
        
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // start bit detected
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            
            START: begin
                if (in == 1'b0) begin // still start bit
                    next_state <= START;
                end
                else begin // start bit ended
                    next_state <= DATA;
                end
            end
            
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 4'b1000) begin // 8 data bits received
                    next_state <= STOP;
                end
                else begin
                    bit_count <= bit_count + 1;
                    next_state <= DATA;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin // stop bit detected
                    out_byte <= data_reg;
                    done <= 1'b1;
                    next_state <= IDLE;
                end
                else begin // stop bit not detected, wait for it
                    next_state <= STOP;
                end
            end
        endcase
    end
end

endmodule
