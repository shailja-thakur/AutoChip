module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam [2:0] IDLE = 3'b000,
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
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                done <= 0;
            end
            START: begin
                if (bit_count == 9) begin // 1 start bit + 8 data bits
                    if (in == 1) begin // Stop bit detected
                        state <= STOP;
                    end else begin
                        state <= IDLE; // Invalid stop bit, restart
                    end
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in}; // Shift in data bits
                    state <= DATA;
                end
            end
            DATA: begin
                if (bit_count == 9) begin
                    state <= STOP;
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in}; // Shift in data bits
                end
            end
            STOP: begin
                if (in == 1) begin // Valid stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin // Invalid stop bit, restart
                    state <= IDLE;
                end
                bit_count <= 0;
            end
        endcase
    end
end

endmodule
