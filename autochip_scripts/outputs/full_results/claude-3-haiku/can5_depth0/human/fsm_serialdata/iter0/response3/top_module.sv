module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
parameter [2:0] IDLE = 3'b000, 
                START = 3'b001,
                DATA = 3'b010,
                STOP = 3'b011;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    state <= START;
                else
                    state <= IDLE;
                done <= 0;
            end
            START: begin
                if (bit_count == 4'd9) begin // Wait for 9 bits (1 start, 8 data)
                    bit_count <= 0;
                    state <= DATA;
                end
                else
                    bit_count <= bit_count + 1;
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]};
                if (bit_count == 4'd8) begin // All 8 data bits received
                    bit_count <= 0;
                    state <= STOP;
                end
                else
                    bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else
                    state <= STOP; // Wait for stop bit
            end
        endcase
    end
end

endmodule
