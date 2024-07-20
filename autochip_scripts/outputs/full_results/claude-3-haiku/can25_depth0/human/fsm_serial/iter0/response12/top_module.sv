module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00, START_BIT = 2'b01, DATA = 2'b10, STOP_BIT = 2'b11;
reg [1:0] state, next_state;
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
                if (in == 1'b0) begin // Start bit detected
                    next_state <= START_BIT;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end
            
            START_BIT: begin
                if (in == 1'b0) begin // Start bit is valid
                    next_state <= DATA;
                end
                else begin // Start bit is invalid, wait for next start bit
                    next_state <= IDLE;
                end
            end
            
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    next_state <= STOP_BIT;
                end
                else begin
                    next_state <= DATA;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit is valid
                    next_state <= IDLE;
                    done <= 1;
                end
                else begin // Stop bit is invalid, wait for next start bit
                    next_state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
