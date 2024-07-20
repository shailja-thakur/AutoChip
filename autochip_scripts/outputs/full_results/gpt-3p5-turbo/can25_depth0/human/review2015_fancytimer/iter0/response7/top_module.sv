module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] shift_reg;
    wire [3:0] delay;
    reg [3:0] count_reg;
    reg start_detect;
    reg [1:0] state;
    reg searching;
    reg count_enable;
    
    always @(posedge clk) begin
        if (reset) begin
            count_reg <= 4'b0;
            shift_reg <= 4'b0;
            start_detect <= 1'b0;
            state <= 2'b00;
            searching <= 1'b1;
            count_enable <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // IDLE state
                    count_reg <= 4'b0;
                    shift_reg <= 4'b0;
                    start_detect <= data;
                    if (start_detect) begin
                        state <= 2'b01;
                    end
                end
                2'b01: begin // DETECT state
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin // COUNT state
                    if (count_enable) begin
                        if (count_reg == (delay - 1)) begin
                            state <= 2'b11;
                        end else begin
                            count_reg <= count_reg + 1;
                        end
                    end
                    if (!count_enable || (count_reg == 4'b0000)) begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin // DONE state
                    if (ack) begin
                        state <= 2'b00;
                    end
                end
            endcase
        end
    end
    
    assign count = count_reg;
    assign delay = shift_reg;
    assign counting = (state == 2'b10) ? 1'b1 : 1'b0;
    assign done = (state == 2'b11) ? 1'b1 : 1'b0;
    assign count_enable = (state == 2'b10) ? 1'b1 : 1'b0;
    
endmodule
