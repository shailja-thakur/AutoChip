module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    localparam IDLE = 3'd0,
               START = 3'd1,
               DATA = 3'd2,
               STOP = 3'd3,
               ERROR = 3'd4;
    
    reg [2:0] state, next_state;
    reg [7:0] shift_reg;
    reg [2:0] bit_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'b0;
            done <= 1'b0;
            shift_reg <= 8'b0;
            bit_count <= 3'd0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) // Start bit detected
                        next_state <= START;
                    else
                        next_state <= IDLE;
                end
                START: begin
                    if (bit_count == 3'd0) begin
                        bit_count <= 3'd1;
                        next_state <= DATA;
                    end
                    else
                        next_state <= START;
                end
                DATA: begin
                    shift_reg <= {in, shift_reg[7:1]};  // Shift in the data bit
                    if (bit_count == 3'd8) begin
                        bit_count <= 3'd0;
                        next_state <= STOP;
                    end
                    else begin
                        bit_count <= bit_count + 1;
                        next_state <= DATA;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin // Correct stop bit
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end
                    else begin
                        done <= 1'b0;
                        next_state <= ERROR;
                    end
                end
               ERROR: begin
                    if (in == 1'b1) // Wait for stop bit
                        next_state <= IDLE;
                    else
                        next_state <= ERROR;
                end
                default: next_state <= IDLE;
            endcase
        end
    end
endmodule
