module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    reg [3:0] state;
    reg [3:0] bit_count;
    reg [7:0] data;
    
    localparam WAIT_START = 4'd0;
    localparam RECEIVE_BITS = 4'd1;
    localparam CHECK_STOP = 4'd2;
    localparam DONE = 4'd3;
    
    // state machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_START;
            bit_count <= 4'd0;
            data <= 8'd0;
            done <= 1'b0;
        end
        else begin
            case (state)
                WAIT_START: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin
                        state <= RECEIVE_BITS;
                        bit_count <= 4'd0;
                    end
                end

                RECEIVE_BITS: begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if (bit_count == 4'd7) begin
                        state <= CHECK_STOP;
                    end
                end

                CHECK_STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= data;
                        done <= 1'b1;
                        state <= DONE;
                    end
                    else begin
                        state <= WAIT_START;
                    end
                end

                DONE: begin
                    done <= 1'b0;
                    if (in == 1'b1) begin
                        state <= WAIT_START;
                    end
                end

                default: begin
                    state <= WAIT_START;
                end
            endcase
        end
    end
endmodule
