module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] state;
    reg [3:0] delay;
    reg [12:0] counter; // maximum (delay[3:0] + 1) * 1000 will be 15 * 1000 = 15000, needs 14 bits.
    
    reg [3:0] bit_cnt;
    reg [3:0] shift_reg;
    
    localparam IDLE = 4'd0;
    localparam DETECT_PATTERN = 4'd1;
    localparam SHIFT_DELAY = 4'd2;
    localparam COUNT = 4'd3;
    localparam DONE = 4'd4;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'b0000;
            counter <= 13'd0;
            bit_cnt <= 4'b0000;
            shift_reg <= 4'b0000;
        end else begin
            case(state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    bit_cnt <= 4'b0000;
                    counter <= 13'd0;
                    count <= 4'b0000;
                    if(data == 1'b1)
                        shift_reg <= {shift_reg[2:0], data}; // shift in incoming data
                    else
                        shift_reg <= {shift_reg[2:0], data}; 
                    if(shift_reg == 4'b1101)
                        state <= SHIFT_DELAY;
                end
                SHIFT_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data}; // shift in incoming data
                    bit_cnt <= bit_cnt + 4'b0001;
                    if(bit_cnt == 4'd4) begin
                        delay <= shift_reg;
                        counter <= 13'd1000 * (shift_reg + 4'd1);
                        state <= COUNT;
                        counting <= 1'b1;
                    end
                end
                COUNT: begin
                    if(counter > 13'd0) begin
                        counter <= counter - 13'd1;
                        if(counter % 13'd1000 == 13'd0) begin
                            count <= count - 4'b0001;
                        end
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= DONE;
                    end
                end
                DONE: begin
                    if(ack == 1'b1) begin
                        state <= IDLE;
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end
endmodule
