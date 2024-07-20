module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_reg;
    reg [2:0] bit_count;
    
    localparam IDLE   = 4'd0,
               START  = 4'd1,
               DATA0  = 4'd2,
               DATA1  = 4'd3,
               DATA2  = 4'd4,
               DATA3  = 4'd5,
               DATA4  = 4'd6,
               DATA5  = 4'd7,
               DATA6  = 4'd8,
               DATA7  = 4'd9,
               STOP   = 4'd10,
               DONE   = 4'd11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
            done <= 1'b0;
            data_reg <= 8'd0;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA0;
            end
            DATA0: begin
                data_reg[0] = in;
                next_state = DATA1;
            end
            DATA1: begin
                data_reg[1] = in;
                next_state = DATA2;
            end
            DATA2: begin
                data_reg[2] = in;
                next_state = DATA3;
            end
            DATA3: begin
                data_reg[3] = in;
                next_state = DATA4;
            end
            DATA4: begin
                data_reg[4] = in;
                next_state = DATA5;
            end
            DATA5: begin
                data_reg[5] = in;
                next_state = DATA6;
            end
            DATA6: begin
                data_reg[6] = in;
                next_state = DATA7;
            end
            DATA7: begin
                data_reg[7] = in;
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    next_state = DONE;
                end else begin // Wait until stop bit detected
                    next_state = IDLE;
                end
            end
            DONE: begin
                out_byte = data_reg;
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
