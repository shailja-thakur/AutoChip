module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE     = 3'b000;
localparam START    = 3'b001;
localparam DATA     = 3'b010;
localparam STOP     = 3'b011;
localparam ERROR    = 3'b100;

reg [2:0] state;
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
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 9 clocks after start bit
                    if (in == 1'b1) begin // Stop bit received correctly
                        state <= STOP;
                        done <= 1'b1;
                    end
                    else begin // Stop bit not received correctly
                        state <= ERROR;
                        done <= 1'b0;
                    end
                end
                else begin
                    bit_count <= bit_count + 1'b1;
                    if (bit_count < 4'd8) begin // Shift in data bits
                        data_reg <= {data_reg[6:0], in};
                    end
                end
            end
            STOP: begin
                done <= 1'b0;
                state <= IDLE;
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
