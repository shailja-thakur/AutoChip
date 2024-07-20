module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [3:0] bit_count;
    reg [7:0] byte_data;
    
    localparam IDLE = 4'd0, START = 4'd1, DATA = 4'd2, STOP = 4'd3, DONE = 4'd4;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            bit_count <= 0;
            out_byte <= 0;
            byte_data <= 0;
        end
        else begin
            done <= 0;
            case (state)
                IDLE: begin
                    if (in == 0) begin  // Start bit detected
                        state <= START;
                        bit_count <= 0;
                    end
                end
                START: begin
                    if (bit_count == 4'd1) begin
                        state <= DATA;
                        bit_count <= 0;
                    end else begin
                        bit_count <= bit_count + 1;
                    end
                end
                DATA: begin
                    byte_data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if (bit_count == 4'd7) begin
                        state <= STOP;
                    end
                end
                STOP: begin
                    if (in == 1) begin  // Stop bit detected
                        out_byte <= byte_data;
                        done <= 1;
                        state <= DONE;
                    end else begin      // Stop bit not detected, wait for stop bit
                        state <= IDLE;
                    end
                end
                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end
  
endmodule
