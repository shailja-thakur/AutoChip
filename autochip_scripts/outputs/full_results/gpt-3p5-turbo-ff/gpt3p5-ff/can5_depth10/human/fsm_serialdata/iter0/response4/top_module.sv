module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_reg;
reg stop_bit;
reg bit_count;

// State definitions
parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_reg <= 8'd0;
        stop_bit <= 1'b0;
        bit_count <= 3'd0;
        done <= 1'b0;
    end else begin
        case(state)
            IDLE: begin
                // Check if start bit received
                if (in == 1'b0) begin
                    state <= START_BIT;
                    bit_count <= 3'd1;
                end
            end
            
            START_BIT: begin
                // Check if data bit received
                if (bit_count < 3'd9) begin
                    data_reg[bit_count-1] <= in;
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end
            end
            
            DATA: begin
                // Check if data bit received
                if (bit_count < 3'd9) begin
                    data_reg[bit_count-1] <= in;
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end
                // Check if stop bit received
                else begin
                    stop_bit <= in;
                    state <= STOP_BIT;
                end
            end
            
            STOP_BIT: begin
                if (stop_bit == 1'b1) begin
                    // Stop bit valid, output received byte and assert done
                    out_byte <= data_reg;
                    done <= 1'b1;
                end
                state <= IDLE;
                data_reg <= 8'd0;
                stop_bit <= 1'b0;
                bit_count <= 3'd0;
            end
        endcase
    end
end

endmodule
