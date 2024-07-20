module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg [2:0] bit_index;
reg stop_bit;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b0;
        data_byte <= 8'b0;
        bit_index <= 3'b0;
        stop_bit <= 1'b0;
        out_byte <= 8'b0;
        done <= 1'b0;
    end else begin
        case(state)
            3'b000: begin // Idle State
                if (in == 1'b0) begin
                    state <= 3'b001;
                end
            end
            
            3'b001: begin // Start State
                if (in == 1'b0) begin
                    state <= 3'b010;
                    data_byte <= 8'b0;
                    bit_index <= 3'b0;
                    stop_bit <= 1'b0;
                end else begin
                    state <= 3'b000;
                end
            end
            
            3'b010: begin // Data State
                if (bit_index < 3'b111) begin
                    if (in == 1'b0) begin
                        bit_index <= bit_index + 3'b001;
                        data_byte[bit_index] <= in;
                    end else begin
                        state <= 3'b001;
                    end
                end else begin
                    if (in == 1'b1) begin
                        state <= 3'b011;
                        stop_bit <= in;
                    else begin
                        state <= 3'b001;
                    end
                end
            end
            
            3'b011: begin // Stop State
                if (in == 1'b1) begin
                    state <= 3'b001;
                    out_byte <= data_byte;
                    done <= 1'b1;
                else begin
                    state <= 3'b000;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
