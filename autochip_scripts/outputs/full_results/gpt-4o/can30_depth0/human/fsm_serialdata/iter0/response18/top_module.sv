module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);
	
    reg [3:0] state;
    reg [2:0] bit_cnt;   // To keep track of received bits
    reg [7:0] shift_reg; // To store received byte
    
    localparam IDLE = 4'd0,
               START = 4'd1,
               DATA = 4'd2,
               STOP = 4'd3,
               DONE = 4'd4;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 3'd0;
            shift_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin // Start bit detected
                        state <= START;
                    end
                end
                
                START: begin
                    if (in == 1'b0) begin // Confirm start bit
                        state <= DATA;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                
                DATA: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 3'd7) begin
                        state <= STOP;
                    end
                end
                
                STOP: begin
                    if (in == 1'b1) begin // Stop bit detected
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        state <= IDLE;
                    end
                    else begin
                        state <= IDLE; // Wait for new start bit
                    end
                    bit_cnt <= 3'd0;
                    shift_reg <= 8'd0;
                end
                
                DONE: begin
                    // Stay in DONE state for one clock cycle to assert done
                    done <= 1'b1;
                    state <= IDLE;
                end
                
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
