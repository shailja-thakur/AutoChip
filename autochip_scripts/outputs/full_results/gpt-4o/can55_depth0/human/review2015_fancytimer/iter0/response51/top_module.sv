module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output reg [3:0] count,
	output reg counting,
	output reg done,
	input wire ack
);

    reg [3:0] state; 
    reg [3:0] next_state; 
    reg [3:0] delay; 
    reg [13:0] count_down;

    localparam SEARCH     = 4'd0,
               SHIFT1     = 4'd1,
               SHIFT2     = 4'd2,
               SHIFT3     = 4'd3,
               SHIFT4     = 4'd4,
               COUNTING   = 4'd5,
               DONE       = 4'd6;

    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
            delay <= 4'b0000;
            count_down <= 14'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                SEARCH: begin
                    count <= 4'bxxxx;
                    delay <= 4'b0000;
                    count_down <= 14'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 1'b1) begin
                        next_state <= SHIFT1;
                    end else begin
                        next_state <= SEARCH;
                    end
                end
                SHIFT1: begin
                    if (data == 1'b1) begin
                        next_state <= SHIFT2;
                    end else begin
                        next_state <= SEARCH;
                    end
                end
                SHIFT2: begin
                    if (data == 1'b0) begin
                        next_state <= SHIFT3;
                    end else begin
                        next_state <= SEARCH;
                    end
                end
                SHIFT3: begin
                    if (data == 1'b1) begin
                        next_state <= SHIFT4;
                    end else begin
                        next_state <= SEARCH;
                    end
                end
                SHIFT4: begin
                    delay <= {data, delay[2:0]};
                    next_state <= COUNTING;
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (count_down == 14'd0) begin
                        count_down <= (delay + 1) * 1000;
                        count <= delay;
                    end else if (count_down == 14'd1) begin
                        if (count > 4'b0000) begin
                            count <= count - 1;
                        end
                        count_down <= 1000;
                    end else begin
                        count_down <= count_down - 1;
                    end
                    if (count == 4'b0000 && count_down == 14'd1) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        next_state <= DONE;
                    end
                end
                DONE: begin
                    counting <= 1'b0;
                    if (ack) begin
                        done <= 1'b0;
                        next_state <= SEARCH;
                    end else begin
                        next_state <= DONE;
                    end
                end
                default: begin
                    next_state <= SEARCH;
                end
            endcase
        end
    end
    
endmodule
