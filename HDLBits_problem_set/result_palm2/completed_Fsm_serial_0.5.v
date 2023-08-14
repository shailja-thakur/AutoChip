module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter STATE_IDLE = 1'b0;
    parameter STATE_START = 1'b1;
    parameter STATE_DATA = 1'b2;
    parameter STATE_STOP = 1'b3;

    reg [1:0] state = STATE_IDLE;
    reg [7:0] data;
    reg done;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
            data <= 8'h0;
            done <= 1'b0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (in == 1'b0) begin
                        state <= STATE_START;
                        data <= 8'h0;
                    end
                end
                STATE_START: begin
                    if (in == 1'b1) begin
                        state <= STATE_DATA;
                        data <= data + in;
                    end else begin
                        state <= STATE_IDLE;
                        done <= 1'b0;
                    end
                end
                STATE_DATA: begin
                    if (in == 1'b0) begin
                        state <= STATE_STOP;
                        if (data == 8'h00) begin
                            done <= 1'b1;
                        end
                    end else begin
                        data <= data + in;
                    end
                end
                STATE_STOP: begin
                    if (in == 1'b1) begin
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end

endmodule