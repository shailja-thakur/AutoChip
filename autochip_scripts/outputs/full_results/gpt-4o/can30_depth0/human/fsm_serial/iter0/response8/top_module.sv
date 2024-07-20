module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state;
    reg [7:0] data_bits;
    reg [2:0] bit_count;

    localparam IDLE       = 4'd0,
               START_BIT  = 4'd1,
               BIT_0      = 4'd2,
               BIT_1      = 4'd3,
               BIT_2      = 4'd4,
               BIT_3      = 4'd5,
               BIT_4      = 4'd6,
               BIT_5      = 4'd7,
               BIT_6      = 4'd8,
               BIT_7      = 4'd9,
               STOP_BIT   = 4'd10,
               CHECK_STOP = 4'd11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_bits <= 8'b0;
            bit_count <= 3'd0;
            done <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) // Detect start bit (0)
                        state <= START_BIT;
                end
                
                START_BIT: begin
                    bit_count <= 3'd0;
                    state <= BIT_0;
                end  

                BIT_0: begin
                    data_bits[0] <= in;
                    state <= BIT_1;
                end

                BIT_1: begin
                    data_bits[1] <= in;
                    state <= BIT_2;
                end

                BIT_2: begin
                    data_bits[2] <= in;
                    state <= BIT_3;
                end

                BIT_3: begin
                    data_bits[3] <= in;
                    state <= BIT_4;
                end

                BIT_4: begin
                    data_bits[4] <= in;
                    state <= BIT_5;
                end
                
                BIT_5: begin
                    data_bits[5] <= in;
                    state <= BIT_6;
                end

                BIT_6: begin
                    data_bits[6] <= in;
                    state <= BIT_7;
                end

                BIT_7: begin
                    data_bits[7] <= in;
                    state <= STOP_BIT;
                end

                STOP_BIT: begin
                    if (in == 1'b1) // Check for stop bit (1)
                        state <= CHECK_STOP;
                    else
                        state <= IDLE;
                end

                CHECK_STOP: begin
                    done <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
