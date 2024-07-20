module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    localparam IDLE       = 4'd0,
               START      = 4'd1,
               BIT0       = 4'd2,
               BIT1       = 4'd3,
               BIT2       = 4'd4,
               BIT3       = 4'd5,
               BIT4       = 4'd6,
               BIT5       = 4'd7,
               BIT6       = 4'd8,
               BIT7       = 4'd9,
               STOP       = 4'd10,
               ERROR      = 4'd11;

    reg [3:0] state;
    reg [3:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in == 0) begin // Detect start bit
                        state <= START;
                    end
                end
                START: begin
                    state <= BIT0; // Move to receive first data bit
                    bit_count <= 0;
                end
                BIT0: begin
                    bit_count <= bit_count + 1;
                    if (bit_count == 0)
                        state <= BIT1;
                end
                BIT1: begin
                    if (bit_count == 1) begin
                        state <= BIT2;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT2: begin
                    if (bit_count == 2) begin
                        state <= BIT3;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT3: begin
                    if (bit_count == 3) begin
                        state <= BIT4;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT4: begin
                    if (bit_count == 4) begin
                        state <= BIT5;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT5: begin
                    if (bit_count == 5) begin
                        state <= BIT6;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT6: begin
                    if (bit_count == 6) begin
                        state <= BIT7;
                        bit_count <= bit_count + 1;
                    end
                end
                BIT7: begin
                    if (bit_count == 7) begin
                        state <= STOP;
                        bit_count <= bit_count + 1;
                    end
                end
                STOP: begin
                    if (in == 1) begin // Verify stop bit
                        done <= 1;
                        state <= IDLE; // Ready for next byte
                    end
                    else begin
                        state <= ERROR; // Invalid stop bit
                    end
                end
                ERROR: begin
                    if (in == 1) begin
                        state <= IDLE; // Wait until line is idle
                    end
                end
            endcase
        end
    end

endmodule
