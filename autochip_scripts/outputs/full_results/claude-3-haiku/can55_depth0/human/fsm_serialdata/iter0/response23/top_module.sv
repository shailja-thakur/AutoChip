module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011;

// Internal registers
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // Start bit and 8 data bits received
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in};
                end
            end
            DATA: begin
                if (bit_count == 4'd8) begin // Stop bit received
                    if (in == 1'b1) begin // Valid stop bit
                        out_byte <= data_reg;
                        done <= 1'b1;
                        state <= IDLE;
                    end
                    else begin // Invalid stop bit, wait for next start bit
                        state <= IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in};
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
