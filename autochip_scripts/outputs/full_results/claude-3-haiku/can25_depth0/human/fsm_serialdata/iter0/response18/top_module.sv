module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011;
reg [2:0] state, next_state;
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
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b0) // Start bit detected
                next_state = START;
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            if (bit_count == 4'd8) // All 8 data bits received
                next_state = STOP;
        end
        STOP: begin
            if (in == 1'b1) // Stop bit detected
                next_state = IDLE;
            else
                next_state = STOP; // Wait for stop bit
        end
    endcase
end

always @(posedge clk) begin
    case (state)
        START: begin
            bit_count <= 0;
            data_reg <= 0;
        end
        DATA: begin
            data_reg <= {data_reg[6:0], in}; // Shift in data bit
            bit_count <= bit_count + 1;
        end
        STOP: begin
            out_byte <= data_reg;
            done <= 1'b1;
        end
        default: begin
            bit_count <= 0;
            data_reg <= 0;
            done <= 1'b0;
        end
    endcase
end

endmodule
